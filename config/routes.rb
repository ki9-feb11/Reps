Rails.application.routes.draw do

  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/new'
    get 'customers/create'
    get 'customers/edit'
    get 'customers/update'
    get 'customers/destroy'
  end
  get 'customers/index'
  get 'customers/show'
  get 'customers/new'
  get 'customers/create'
  get 'customers/edit'
  get 'customers/update'
  get 'customers/destroy'
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
  end



  #ユーザー用ルーティング
  scope module: :public do
    root to: 'homes#top'
    get '/about', to: 'homes#about'
    resources :posts
    resources :customers, only: [:index, :show, :edit, :update]
  end

end
