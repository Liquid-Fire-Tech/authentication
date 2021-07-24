require_relative 'concerns/extra_concern'

module Authentication
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Authentication::Generators::Concerns::ExtraConcern
      desc 'Full installation of authentication module with devise, devise_auth_token, rolify and pundit'

      source_root File.expand_path('templates', __dir__)

      class_option :skip_devise, type: :boolean, default: false, desc: 'Skip devise setup'
      class_option :skip_base_controller, type: :boolean, default: false, desc: 'Skip base controller setup'
      class_option :skip_rolify, type: :boolean, default: false, desc: 'Skip rolify setup'
      class_option :skip_pundit, type: :boolean, default: false, desc: 'Skip pundit setup and '

      class_option :authentication_mount, type: :string, default: 'auth',
                                          desc: 'Define the model for user authentication'
      class_option :model, type: :string, default: 'User', desc: 'Define the model for user authentication'
      class_option :roles, type: 'array', default: ['admin'], desc: 'Roles to create by default'

      def check_requirements
        gem_find_or_fail(%w[devise devise_token_auth pundit rolify])
      end

      def setup_devise_and_devise_token_auth
        unless options.skip_devise
          generate 'devise:install'
          generate 'devise_token_auth:install', options.model, options.authentication_mount

          migrate_user_file = find_or_fail('db/migrate/[0-9]*_create_users.rb')

          inject_into_file migrate_user_file, after: "t.string :email\n" do
            snippet_for_user_phone_number
          end

          system 'rails db:migrate'

          # TODO: Enable omniauth in user model
        end
      end

      def setup_api_v1
        unless options.skip_base_controller
          copy_file 'lib/api_version.rb', 'app/lib/api_version.rb'

          generate 'controller',
                   'api/v1/base --skip-template-engine --no-helper --no-assets --no-controller-specs --no-view-specs'
          gsub_file 'app/controllers/api/v1/base_controller.rb', /ApplicationController/, 'ActionController::API'

          inject_into_file 'app/controllers/api/v1/base_controller.rb',
                           after: "ActionController::API\n" do
            snippet_base_ctrl_header
          end

          inject_into_file 'app/controllers/application_controller.rb',
                           after: "::SetUserByToken\n" do
            snippet_application_ctlr_header
          end
        end
      end

      def setup_rolify
        unless options.skip_rolify
          system "rails g rolify Role #{options.model}"
          system 'rails db:migrate'

          empty_directory 'db/seeds'

          roles_create_query = ''
          options.roles.each do |role|
            roles_create_query += "Role.create(name: '#{role.underscore}')\n"
          end
          template 'roles.rb', 'db/seeds/roles.rb'
          inject_into_file 'db/seeds.rb' do
            "load 'db/seeds/roles.rb'"
          end
          inject_into_file 'db/seeds/roles.rb' do
            roles_create_query
          end

          system 'rails db:seed'
          # options.roles.each do |role|
          #   generate 'controller', "api/v1/#{role.underscore}/base --skip-template-engine --no-helper --no-assets --no-controller-specs --no-view-specs"
          #   gsub_file "app/controllers/api/v1/#{role.underscore}/base_controller.rb", /ApplicationController/, 'Api::V1::BaseController'
          # end
        end
      end

      def setup_pundit
        # TODO: /api/v1/role_name/base_controller create policies
      end

      def setup_devise_routes
        unless options.skip_devise
          gsub_file 'config/routes.rb', /mount_devise_token_auth_for 'User', at: 'auth'/,
                    "devise_for :#{options.model.underscore.pluralize}"
          route snippet_routes_root_path(options.model, options.authentication_mount)
        end
      end
    end
  end
end
