class Public::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to recipe_path(@recipe.id)
    else
      flash[:notice] = "投稿内容に不備があります。"
      render :new
    end
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:notice] = "投稿内容の変更が完了しました。"
      redirect_to recipe_path(@recipe.id)
    else
      flash[:notice] = "投稿変更内容に不備があります。"
      render :edit
    end
  end
  
  private
  def recipe_params
    params.require(:recipe).permit(:image, :title, :description,:end_user_id)
  end
  
end