class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!
  # フォローするとき
  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end
  # フォロー一覧
  def follower
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end
  # フォロワー一覧
  def followed
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end
end
