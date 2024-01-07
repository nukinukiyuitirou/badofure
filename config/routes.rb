Rails.application.routes.draw do
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/followings'
    get 'users/followers'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'message/edit'
  end
  namespace :public do
    get 'rooms/show'
  end
  namespace :public do
    get 'user/show'
    get 'user/edit'
    get 'user/confirm'
  end
  # 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
