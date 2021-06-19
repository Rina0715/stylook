Rails.application.routes.draw do

  get 'search/search'
  devise_for :users
  root to: 'homes#top'

  resources :search, only: :edit
  get '/search' => 'search#search'

  resources :genres

  resources :articles, only: [:new, :create, :index, :show, :destroy] do
    resource :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
    resources :favorites, only: [:create, :destroy, :index]
  end

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    patch '/users/withdrawal' => 'users#destroy'
    get '/users/withdrawal' => 'users#withdrawal'
  end
  resources :notifications, only: :index

end
