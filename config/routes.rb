Rails.application.routes.draw do
  devise_for :users
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
   namespace :admin do
    get "/" => "homes#top"

    resources :posts, only: [:index,:show,:destroy] do
      resources :comments, only: [:destroy]
      get "search" => "searchs#search"
    end
    resources :users, only: [:index,:show,:edit,:updete,:destroy] do
      get "following" => "relationships#followings", as: "followings"
      get "follower" => "relationships#followers", as: "followers"
    end

    #resources :sessions, only: [:new,:create,:destroy]
    #検索機能を入れる予定

  end


  scope module: :public do
    root to: "homes#top"
    resources :posts, only: [:index,:new,:create,:show,:edit,:update,:destroy] do
     resources :comments, only: [:create,:destroy]
     resource :favorite, only: [:create,:destroy]
   end
    get "search" => "searhs#searh"

    devise_scope :user do
    resources :users, only: [:index,:show,:edit,:update]do
      patch "unsubscribe" => "users#unsubscribe", as: "users_unsubscrites"
      get "favorites" => "users#favorites"
      patch "withdraw" => "users#withdraw"
      resource :relationship, only: [:create,:destroy]
      get "following" => "relationships#followings", as: "followings"
      get "follower" => "relationships#followers", as: "followers"
    end
        post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end
    resources :rooms, only: [:index,:show,:create]
    resources :messages, only: [:create]




    #検索機能を入れる予定

end

  # 顧客用
 #URL /customers/sign_in ...
# devise_for :users,skip: [:passwords], controllers: {
#   registrations: "public/registrations",
#   sessions: 'public/sessions'
# }

# 管理者用
# URL /admin/sign_in ...
#devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  #sessions: "admin/sessions"
#}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
