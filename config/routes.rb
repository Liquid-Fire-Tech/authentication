Authentication::Engine.routes.draw do
  # devise_for :users, controllers: {
  #   registrations: 'authentication/registrations'
  # }
  # devise_for :users
  resources :inits, only: [:index]

  mount_devise_token_auth_for 'User', at: 'auth'
  as :user do
    # Define routes for User within this block.
  end

  # mount_devise_token_auth_for 'User', at: 'user', controllers: {
  #   registrations: 'authentication/api/v1/user/registrations',
  #   sessions:      'authentication/api/v1/user/sessions'
  # }
end
