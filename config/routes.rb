Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  post 'login_as_sue', to: 'guest_sessions#sue'
  post 'login_as_taro', to: 'guest_sessions#taro'
  
  
  get "start", to: "records#new"
  
  resources :users, only: [:index, :show, :new, :edit, :create, :update] do
    member do 
      get :followings
      get :followers
      get :likes
      get :records
    end
  end
  
  resources :microposts, only: [:index, :create, :destroy] do
    member do
      get :following_posts
    end
  end
  
  resources :records, only: [:show, :new, :edit, :create, :update] do
    member do
      get :finish
      get :result
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
