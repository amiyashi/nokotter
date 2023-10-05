class Public::BookmarksController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    bookmark = current_customer.bookmarks.new(recipe_id: recipe.id)
    bookmark.save
    redirect_to recipe_path(recipe)
  end
  
  def destroy
    recipe = Recipe.find(params[:recipe_id])
    bookmark = current_customer.bookmarks.find_by(recipe_id: recipe.id)
    bookmark.destroy
    redirect_to recipe_path(recipe)
  end
end
