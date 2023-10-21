class Public::CustomersController < ApplicationController
  # ログインしてるユーザーにのみプロフィール見れる
  # before_action :authenticate_user!
  before_action :ensure_normal_customer, only: [:edit, :update, :withdrawal]

  def new
    @customer = Customer.new
  end

  def show
    @customer = Customer.find(params[:id])
    # 該当する人の投稿のみ表示させる
    @recipes = Recipe.where(customer_id: @customer.id).includes(:customer).order("created_at DESC")
    # フォローフォロワー
    @following_customers = @customer.followings
    @follower_customers = @customer.followers
    bookmark = Bookmark.where(customer_id: current_customer.id).pluck(:recipe_id)
    @bookmark_list = Recipe.find(bookmark)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = current_customer
    if customer.update(customer_params)
      redirect_to customer_path(customer)
    else
      :edit
    end
  end

  # def confirm_withdrawal
  #   @customer = current_customer
  # end

  def withdrawal
    @customer = current_customer
    # 退会済み会員の場合
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  # フォロー一覧
  def followings
    @customer = Customer.find(params[:id])
    @customers = @customer.followings
  end
  # フォロワー一覧
  def followers
    @customer = Customer.find(params[:id])
    @customers = @customer.followers
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :birth_date, :customer_id, :profile_image, :email)
  end

  def ensure_normal_customer
    @customer = current_customer
    if @customer.email == 'guest@example.com'
     redirect_to root_path, alert: 'ゲストユーザーはプロフィール編集できません。'
    end
  end

end
