Rails.application.routes.draw do
  resources :studio, only: [:index]
end
