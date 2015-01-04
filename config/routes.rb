Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  resources :voters, only: [:new, :create, :show, :edit, :update, :destroy]

  resources :searches
end
