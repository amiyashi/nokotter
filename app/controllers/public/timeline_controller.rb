class Public::TimelineController < ApplicationController
  def index
    @customer = Customer.find(current_customer.id)
    # フォローユーザー情報取得
    @following_customers = @customer.followings
    # すべてのレシピの中から、自分がフォローしてるユーザーのレシピのみを探して表示
    @recipes = Recipe.where(customer_id: @following_customers).order("created_at DESC")
  end
end