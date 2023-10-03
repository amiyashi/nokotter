Rails.application.routes.draw do
  # devise_for :customers
  # devise_for :end_users

  # skipオプション：不要なルーティングを削除
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  # 管理者とユーザーで区別
  devise_for :customers,controllers: {
  sessions: "public/sessions",
  passwords: 'public/passwords',
  registrations: 'public/registrations',
}

  # ゲストユーザー
  devise_scope :public do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  scope module: :public do
    root to: 'homes#top'
    get 'about' => "homes#about"
    resources :bookmarks, only: [:index, :show, :edit, :update, :destroy]
    patch 'members/withdrawal' => "members#withdrawal"
    get 'members/confirm_withdrawal' => "members#confirm_withdrawal"
    resources :recipes, only: [:index, :new, :create, :show, :edit,:update, :destroy]
  end

  namespace :admin do
    get "" => "homes#top"
    resources :members, only: [:index, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
