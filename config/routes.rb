Rails.application.routes.draw do
  resources :studio, only: [:index]

  resources :movie, only: [:show]
end
