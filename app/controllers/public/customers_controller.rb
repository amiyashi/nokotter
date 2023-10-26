class Public::CustomersController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update]
  before_action :ensure_normal_customer, only: [:edit, :update, :withdrawal]
  before_action :check_customer_status,  only:[:show]

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
    @customer = Customer.find(params[:id])
    # 退会済み会員の場合
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
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

  def is_matching_login_customer
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to recipes_path, alert: '?'
    end
  end

  def ensure_normal_customer
    @customer = current_customer
    if @customer.email == 'guest@example.com'
     redirect_to customer_path(@customer), alert: 'ゲストユーザーはプロフィール編集できません。'
    end
  end

  def check_customer_status
    customer = Customer.find(params[:id])
    if customer.is_deleted
      redirect_to root_path, alert: '退会済みのため再度登録し、お楽しみください。'
    end
  end

end
