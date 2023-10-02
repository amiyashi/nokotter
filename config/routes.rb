Rails.application.routes.draw do
  namespace :end_user do
    get 'relationships/index'
  end
  devise_for :admins
  devise_for :end_users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
