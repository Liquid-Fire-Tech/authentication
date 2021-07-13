require 'date'

module Authentication
  module Generators
    class InstallGenerator < Rails::Generators::Base

      # namespace "authentication"

      desc "Update routes to point to engine"

      # hook_for :orm, required: true

      # class_option :routes, desc: "Generate routes", type: :boolean, default: true

      source_root File.expand_path("../templates/", __FILE__)
      source_root File.expand_path("../../../config/initializers", __FILE__)

      def add_authentication_routes
        authentication_route  = "mount Authentication::Engine, at: '/auth'"
        # authentication_route << "\ndevise_for :users"
        route authentication_route
      end

      def copy_migrations_models
        migrations = Dir[Authentication::Engine.root.join("lib/generators/templates/migrations/*.rb")]
        migrations.each_with_index do |migration, i|
      
          seconds = (DateTime.now.strftime("%S").to_i + i).to_s
          seconds = seconds.to_s.length == 2 ? seconds : "0#{seconds}"
          timestamp = (DateTime.now.strftime "%Y%m%d%H%M") + seconds
          name = migration.split("/").last.split("_")[1..-1].join('_')
          if Rails.root.join("db/migrate/*#{name}").exist?
            puts "Migration #{name} has already been copied to your app"
          else
            copy_file migration, "db/migrate/#{timestamp}_#{name}"
          end
        end

        # for lack of a better solution
        models = Dir[Authentication::Engine.root.join("lib/generators/templates/models/*.rb")]
        models.each do |model|
          copy_file model, "app/models/#{model.split("/").last}"
        end
      end

      # def copy_initializers
      #   copy_file Authentication::Engine.root.join("config/initializers/devise.rb"), "config/initializers/devise.rb"
      # end
    end
  end
end