Authentication::Engine.routes.draw do
  devise_for :users, class_name: 'Authentication::User'
  # mount_devise_token_auth_for 'User', at: 'auth', controllers: {
  #   registrations: 'registrations'
  # }
end
