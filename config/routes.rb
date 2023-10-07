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
    resource :homes, only: %i() do
      get :about
    end

    resources :recipes do
      resources :comments, only: %i(create destroy)
      resource :bookmarks, only: %i(show create destroy)
      # 1人のユーザーは1つの投稿に対して1回しかいいねできない➝id受け渡し必要ない➝resource(単数形)
      collection do
        get :search_tag
      end
    end

    resources :customers, only: %i(show edit update) do
      resource :relationships, only: %i(show create destroy)
      resources :timeline, only: %i(index)
      # idを渡さないとき➝collection
      collection do
        get :confirm_withdrawal
        patch :withdrawal
      end
      # idを渡すとき➝member
      member do
        get :followings
        get :followers
      end
    end

  end

  namespace :admin do
    get "" => "homes#top"
    resources :customers, only: %i(index show)
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
