class Public::CommentsController < ApplicationController
  # before_action :ensure_normal_customer, only: [:create, :destroy]

  def create
    recipe = Recipe.find(params[:recipe_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.recipe_id = recipe.id
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end