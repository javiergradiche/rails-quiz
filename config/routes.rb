Rails.application.routes.draw do
  resources :companies
  resources :people, only: [:index, :new, :create]
  root to: 'people#index'
end
