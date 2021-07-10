require 'devise'
require 'devise_token_auth'

module Authentication
  class Engine < ::Rails::Engine
    isolate_namespace Authentication
  end
end
