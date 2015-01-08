Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  resources :voters, only: [:new, :create, :show, :edit, :update, :destroy]

  resources :lists, only: [:create, :show, :index, :update, :destroy]

  resources :searches
end
