Rails.application.routes.draw do

  # 非ログイン時も表示可能
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: "about"

  # urlにpublicをつけない
  scope module: :public do
    resources :users, only: [:show, :index, :update]
  end

  get '/users/unsubscribe', to: 'public/users#unsubscribe', as: "unsubscribe_user"
  patch '/users/withdraw', to: 'public/users#withdraw', as: "withdraw_user"

  # urlにadminをつける
  namespace :admin do
    resources :headwares, only: [:index, :create]
  end

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
