Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  authenticate :user do
    resources :voters, only: [:new, :create, :show, :edit, :update, :destroy, :index] do
      collection { post :import }
      member do
        resources :contacts, only: [:new, :create, :show]
      end
    end

    resources :lists, only: [:create, :show, :index, :update, :destroy] do
      member do
        get "map_view"
        get "contact_map"
      end
    end

    resources :searches

    resources :list_memberships, only: [:create, :destroy]

    post "turfs", to: "turfs#create"
  end
end
