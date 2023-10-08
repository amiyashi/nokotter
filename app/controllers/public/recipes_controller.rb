class Public::RecipesController < ApplicationController
  def index
    @customer = current_customer
    @tag_list = Tag.all
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result(distinct: true).includes(:customer).order(created_at: :desc)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:recipe][:name].split(',')
    if @recipe.save
      @recipe.save_tags(tag_list)
      flash[:notice] = "投稿が完了しました。"
      redirect_to recipe_path(@recipe.id)
    else
      flash[:notice] = "投稿内容に不備があります。"
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
    @tag_list = @recipe.tags.pluck(:name).join(',')
    @recipe_tags = @recipe.tags
    @customer = current_customer
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @tag_list = @recipe.tags.pluck(:name).join(',')
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
    Comment.find(params[:id]).destroy
    redirect_to recipe_path(params[:recipe_id])
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes
  end

  private
  def recipe_params
    params.require(:recipe).permit(:image, :title, :description, :customer_id)
  end

end