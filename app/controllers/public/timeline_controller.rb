class Public::TimelineController < ApplicationController
  def index
    @recipes = Recipe.includes(:customer, :bookmarks, :tags)
    @customer = Customer.find(current_customer.id)
    # フォローユーザー情報取得
    @following_customers = @customer.followings
    # すべてのレシピの中から、自分がフォローしてるユーザーのレシピのみを探して表示
    @timeline = @recipes.where(customer_id: @following_customers).order("created_at DESC")
  end
end