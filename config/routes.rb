Rails.application.routes.draw do

  # ユーザーログイン
  devise_for :users, skip: [:registrations, :password], controllers: {
    sessions: "public/sessions"
  }

   #管理者ログイン
  devise_for :admins, skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"
  }

  #管理者用ルーティング
  namespace :admin do
    root to: 'homes#top'
    get '/about', to: 'homes#about'
    resources :users
    resources :customers
    resources :products
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :tags, only: [:index, :new, :create, :edit, :update, :destroy]
  end



  #ユーザー用ルーティング
  scope module: :public do
    root to: 'homes#top'
    get '/about', to: 'homes#about'
    get 'users/mypage', to: 'users#mypage', as: :mypage
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
    resources :customers, only: [:index, :show, :edit, :update]
    resources :products, only: [:index, :show]
  end

end
