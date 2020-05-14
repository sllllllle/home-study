Rails.application.routes.draw do
  root to: "toppages#index"
  
  # ログイン機能
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  # 簡単ログイン
  post 'login_as_suenaga', to: 'guest_sessions#suenaga'
  post 'login_as_katsuyuki', to: 'guest_sessions#katsuyuki'
  
  # 勉強を始める
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
  
  resources :records, only: [:index, :show, :new, :edit, :create] do
    member do
      get :stop
      get :restart
      get :finish
      get :result
    end
  end
  
  resources :supports, only: [:create, :destroy] do
    collection do
      get :supporters
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resource :password, only: [:show, :edit, :update]
end
