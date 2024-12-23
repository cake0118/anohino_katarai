Rails.application.routes.draw do

  # 非ログイン時も表示可能
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: "about"

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # urlにpublicをつけない
  scope module: :public do
    resources :users, only: [:show, :index, :edit, :update]
    resources :games, only: [:new, :show, :index, :create] do
      resources :groups, only: [:new, :create, :show] do #indexはgames/showページに表示する為なし
        member do
          post 'join', to: 'groups#join'
          delete 'leave', to: 'groups#leave'
        end
        resources :comments, only: [:create, :destroy, :update]
      end
    end
    resources :searches, only: [:index]
  end

  get '/users/:id/unsubscribe', to: 'public/users#unsubscribe', as: "unsubscribe_user"
  patch '/users/:id/withdraw', to: 'public/users#withdraw', as: "withdraw_user"

  # urlにadminをつける
  namespace :admin do
    resources :headwares, only: [:index, :create]
    resources :users, only: [:edit, :show, :index, :update]
    resources :games, only: [:edit, :show, :index, :update]
  end

  

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
