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
  end



  #ユーザー用ルーティング
  scope module: :public do
    root to: 'homes#top'
    get '/about', to: 'homes#about'
    resources :posts
    resources :customers, only: [:index, :show, :edit, :update]
  end

end
