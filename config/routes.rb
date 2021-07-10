Authentication::Engine.routes.draw do
  # devise_for :users, controllers: {
  #   registrations: 'authentication/registrations'
  # }
  devise_for :users, controllers: {
    registrations: 'authentication/registrations'
  }
  resources :inits, only: [:index]
end
