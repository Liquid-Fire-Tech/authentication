module Authentication
  module Generators
    module Concerns
      module ExtraConcern

        def gem_find_or_fail( list )
          need_fail = false
          alert_color = :red
          list.each do |gem_name|
            gem_msg = `gem list -i #{gem_name}`
            if /false/i =~ gem_msg
              say_status(
                  "error",
                  "gemfile not found: #{gem_name} is required",
                  alert_color
              )
              need_fail = true
            end # unless missing
          end # each constant to be checked
  
          if need_fail
            say("-------------------------------------------------------------------------", alert_color)
            say("-   add required gems to Gemfile; then run bundle install", alert_color)
            say("-   then retry rails g milia:install", alert_color)
            say("-------------------------------------------------------------------------", alert_color)
            raise Thor::Error, "************  terminating generator due to missing requirements!  *************"
          end  # need to fail
        end

        def model_path(filename)
          File.join("app", "models", "#{filename}.rb")
        end

        def inject_rolify_method_after
          /class #{class_name.camelize}\n|class #{class_name.camelize} .*\n|class #{class_name.demodulize.camelize}\n|class #{class_name.demodulize.camelize} .*\n/
        end

        def find_or_fail(filename)
          user_file = Dir.glob(filename).first
          if user_file.blank?
            say_status('error', "file: '#{filename}' not found", :red)
            raise Thor::Error, '************  terminating generator due to file error!  *************'
          end
          user_file
        end

        def snippet_for_user_phone_number
          <<-'RUBY1'
          t.string :phone_number
          RUBY1
        end

        def snippet_home_ctlr_header
          <<-'RUBY2'
          protect_from_forgery with: :null_session

          protected
          def authenticate_user!
            redirect_to root_path, notice: 'Please sign in' unless user_signed_in?
          end
          RUBY2
        end

      end
    end
  end
end
