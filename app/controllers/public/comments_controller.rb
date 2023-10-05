class Public::CommentsController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_customer.comments.new(comment_params)
    comment.recipe_id = recipe.id
    comment.save
    redirect_to recipe_path(recipe)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end