Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  resources :keywords, only: [:index, :create, :show]
end
