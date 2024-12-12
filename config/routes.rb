Rails.application.routes.draw do

  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: "about"

  scope module: :public do
    resources :users, only: [:show, :index, :update]
  end

  get '/users/unsubscribe', to: 'public/users#unsubscribe', as: "unsubscribe_user"
  patch '/users/withdraw', to: 'public/users#withdraw', as: "withdraw_user"

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
