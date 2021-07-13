require_relative 'concerns/extra_concern'

module Authentication
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Authentication::Generators::Concerns::ExtraConcern
      desc 'Full installation of authentication module with devise, devise_auth_token, rolify and pundit'

      source_root File.expand_path('templates', __dir__)

      class_option :model, type: :string, default: 'User', desc: 'define the model for user authentication'
      class_option :authentication_mount, type: :string, default: 'auth', desc: 'define the model for user authentication'
      class_option :skip_devise, type: :boolean, default: false, desc: 'skip devise setup'
      class_option :skip_base_controller, type: :boolean, default: false, desc: 'skip base controller setup'

      def check_requirements
        gem_find_or_fail(%w[devise devise_token_auth])
      end

      def setup_devise_and_devise_token_auth
        unless options.skip_devise
          generate 'devise:install'
          generate 'devise_token_auth:install', options.model, options.authentication_mount

          migrate_user_file = find_or_fail('db/migrate/[0-9]*_create_users.rb')

          inject_into_file migrate_user_file, after: "t.string :email\n" do
            snippet_for_user_phone_number
          end

          system "rails db:migrate"

          # TODO: Enable omniauth in user model
        end
      end

      def setup_api_v1
        unless options.skip_base_controller
          copy_file 'lib/api_version.rb', 'app/lib/api_version.rb'

          generate 'controller', 'api/v1/base --skip-template-engine --no-helper --no-assets --no-controller-specs --no-view-specs'
          
          inject_into_file 'app/controllers/application_controller.rb',
                          after: "::SetUserByToken\n" do
            snippet_home_ctlr_header
          end
        end
      end

      def setup_rolify
        system "rails g rolify Role #{options.model}"
        system "rails db:migrate"
      end
    end
  end
end
