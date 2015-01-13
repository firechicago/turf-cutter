Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  resources :voters, only: [:new, :create, :show, :edit, :update, :destroy]

  resources :lists, only: [:create, :show, :index, :update, :destroy] do
    member do
      get "map_view"
    end
  end

  resources :searches

  resources :list_memberships, only: [:create, :destroy]
end
