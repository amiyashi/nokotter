class Public::BookmarksController < ApplicationController

  def show
     # ブックマーク一覧
    bookmark = Bookmark.where(customer_id: current_customer.id).pluck(:recipe_id)
    @bookmark_list = Recipe.find(bookmark)
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    bookmark = current_customer.bookmarks.new(recipe_id: recipe.id)
    bookmark.save
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    bookmark = current_customer.bookmarks.find_by(recipe_id: recipe.id)
    bookmark.destroy
  end
end
