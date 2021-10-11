Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :purchases, only: [:index, :create]
    resources :comments, only: [:create]
  end
  
  resources :users, only: [:show, :update, :new, :create, :edit]
  resources :cards, only: [:new, :create]
end
