class Public::RecipesController < ApplicationController
  # before_action :check_customer, only: [:edit]
  # before_action :ensure_normal_customer, only: [:new, :create, :edit, :update, :destroy]

  def index
    @customer = current_customer
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result(distinct: true).includes(:customer).order(created_at: :desc)
    # @recipe = Recipe.find(params[:id])
    # @tag_list = @recipe.tags.pluck(:name).join(',')
  end

  def new
    @recipes = Recipe.all
    @recipe = Recipe.new
    @recipe.ingredients.build
    @recipe.procedures.build
  end

  def create
    @recipes = Recipe.all
    @recipe = current_customer.recipes.new(recipe_params)
    @recipe.customer_id = current_customer.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:recipe][:name].split(',')
    # tag_list = params[:recipe][:name].split(',')
    if @recipe.save
      @recipe.save_tags(tag_list)
      redirect_to recipe_path(@recipe)
      flash[:notice] = "レシピを投稿しました！"
    else
      flash.now[:alert] = "投稿内容に不備があります。"
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
    @tag_list = @recipe.tags.pluck(:name).join(',')
    @recipe_tags = @recipe.tags
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @tag_list = @recipe.tags.pluck(:name).join(',')
    if @recipe.customer != current_customer
    redirect_to recipes_path, alert: "他のユーザーのレシピを編集することはできません。"
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    tag_list = params[:recipe][:name].split(',')
    if @recipe.update(recipe_params)
      @recipe.save_tags(tag_list)
      flash[:notice] = "投稿内容の変更が完了しました。"
      redirect_to recipe_path(@recipe.id)
    else
      flash[:notice] = "投稿変更内容に不備があります。"
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    # Comment.find(params[:id]).destroy
    redirect_to new_recipe_path
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes
  end

  private
  def recipe_params
    params.require(:recipe).permit(:image, :title, :customer_id, procedures_attributes: [:id, :body, :_destroy], ingredients_attributes: [:id, :name, :amount, :_destroy])
  end

  def customer_params
    params.require(:customer).permit(:nickname, :birth_date, :customer_id)
  end

  # def check_customer
  #   unless current_customer == @customer
  #   redirect_to root_path, alert: "他のユーザーのマイページにはアクセスできません。"
  #   end
  # end

  # def ensure_normal_customer
  #   @customer = current_customer
  #   if @customer.email == 'guest@example.com'
  #   redirect_to root_path, alert: 'ゲストユーザーの新規投稿はできません。'
  #   end
  # end

end