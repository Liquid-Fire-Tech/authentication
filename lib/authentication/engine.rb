require 'devise'

module Authentication
  class Engine < ::Rails::Engine
    isolate_namespace Authentication
  end
end
