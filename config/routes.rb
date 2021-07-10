Authentication::Engine.routes.draw do
  # devise_for :users, controllers: {
  #   registrations: 'authentication/registrations'
  # }
  devise_for :users
  resources :inits, only: [:index]

  namespace :api do
    scope module: :v1, constraints: Authentication::ApiVersion.new('v1', true) do
      mount_devise_token_auth_for 'User', at: 'users', controllers: {
        registrations: 'api/v1/user/registrations'
      }

      namespace :user do

      end
    end
  end
end
