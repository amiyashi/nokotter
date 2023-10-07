class Public::TimelineController < ApplicationController
  def index
    # タイムライン表示
    @recipes_all = Recipe.includes(:customer,:tag,:bookmark)
    @customer = Customer.find(current_customer.id)
    # フォローユーザー情報取得
    @follow_customers = @customer.all_following
    # すべてのレシピの中から、自分がフォローしてるユーザーのレシピのみを探して表示
    @recipes = @recipes_all.where(customer_id: @follow_customers).order("created_at DESC")
  end
end