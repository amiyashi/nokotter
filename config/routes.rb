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
  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  scope module: :public do
    root to: 'homes#top'
    get 'about' => "homes#about"
    resources :recipes do
      resources :comments, only: [:create, :destroy]
      resource :bookmarks, only: [:index, :create, :destroy]
      # 1人のユーザーは1つの投稿に対して1回しかいいねできない➝id受け渡し必要ないresource(単数形)
    end
    patch 'customers/withdrawal' => "customers#withdrawal"
    get 'customers/confirm_withdrawal' => "customers#confirm_withdrawal"
    resources :customers, only: [:show, :edit, :update]
    get "search_tag" => "recipes#search_tag"
  end

  namespace :admin do
    get "" => "homes#top"
    resources :customers, only: [:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
