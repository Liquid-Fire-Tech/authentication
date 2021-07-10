require 'date'

module Authentication
  module Generators
    class InstallGenerator < Rails::Generators::Base

      # namespace "authentication"

      desc "Update routes to point to engine"

      # hook_for :orm, required: true

      # class_option :routes, desc: "Generate routes", type: :boolean, default: true

      source_root File.expand_path("../../../db/migrate/", __FILE__)

      def add_authentication_routes
        authentication_route  = "mount Authentication::Engine, at: '/auth'"
        route authentication_route
      end

      def copy_migrations
        migrations = Dir[Authentication::Engine.root.join("db/migrate/*.rb")]
        migrations.each_with_index do |migration, i|
      
          seconds = (DateTime.now.strftime("%S").to_i + i).to_s
          seconds = seconds.to_s.length == 2 ? seconds : "0#{seconds}"
          timestamp = (DateTime.now.strftime "%Y%m%d%H%M") + seconds
          name = migration.split("/").last.split("_").last
          if Rails.root.join("db/migrate/*#{name}").exist?
            puts "Migration #{name} has already been copied to your app"
          else
            copy_file migration, "db/migrate/#{timestamp}_authenticaiton_#{name}"
          end
        end
      end
    end
  end
end