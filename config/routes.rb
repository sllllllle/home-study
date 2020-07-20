Rails.application.routes.draw do
  root to: 'toppages#index'

  # サイトの使い方ページ
  get 'about', to: 'toppages#about'

  # ログイン機能
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # 簡単ログイン
  post 'easy_login', to: 'guest_sessions#test'

  # 勉強を始める
  get 'start', to: 'records#new'

  resources :users, only: %i[index show new edit create update] do
    member do
      get :followings
      get :followers
      get :likes
      get :records
    end
  end

  resources :microposts, only: %i[index create destroy] do
    member do
      get :following_posts
    end
  end

  resources :records, only: %i[index show new edit create] do
    member do
      get :stop
      get :restart
      get :finish
      get :result
    end
  end

  resources :supports, only: %i[create destroy] do
    collection do
      get :supporters
    end
  end

  resources :relationships, only: %i[create destroy]
  resources :favorites, only: %i[create destroy]
  resource :password, only: %i[show edit update]
end
