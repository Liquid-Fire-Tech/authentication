require 'devise'
require 'devise_token_auth'
require 'rolify'

module Authentication
  class Engine < ::Rails::Engine
    isolate_namespace Authentication
  end
end
