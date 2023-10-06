class Public::CustomersController < ApplicationController

  def new
    @customer = Customer.new
  end

  def show
    @customer = current_customer
    # 自分の投稿のみ表示させる
    @recipes = Recipe.where(customer_id: current_customer.id).includes(:customer).order("created_at DESC")
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to customer_path(customer)
  end

  def confirm_withdrawal
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
    # 退会済み会員の場合
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  # # フォロー一覧
  # def followings
  #   customer = Customer.find(params[:customer_id])
  #   @customers = customer.followings
  # end
  # # フォロワー一覧
  # def followers
  #   customer = Customer.find(params[:customer_id])
  #   @customers = customer.followers
  # end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date)
  end

end
