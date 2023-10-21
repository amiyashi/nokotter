class Public::BookmarksController < ApplicationController
  # before_action :ensure_normal_customer, only: [:create, :destroy]

  def show
     # ブックマーク一覧
    bookmark = Bookmark.where(customer_id: current_customer.id).pluck(:recipe_id)
    @bookmark_list = Recipe.find(bookmark)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    bookmark = current_customer.bookmarks.new(recipe_id: @recipe.id)
    bookmark.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    bookmark = current_customer.bookmarks.find_by(recipe_id: @recipe.id)
    bookmark.destroy
  end

  # def ensure_normal_customer
  #   @customer = current_customer
  #   if @customer.email == 'guest@example.com'
  #   redirect_to root_path, alert: 'ゲストユーザーの保存機能はできません。'
  #   end
  # end

end
