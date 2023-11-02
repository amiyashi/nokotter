class Public::CommentsController < ApplicationController
  # before_action :ensure_normal_customer, only: [:create, :destroy]

  def create
    @recipe = Recipe.find(params[:recipe_id])
    score = Language.get_data(comment_params[:content])
    if score > 0.0
      comment = @recipe.comments.new(comment_params)
      comment.customer_id = current_customer.id
      comment.save
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    @recipe = comment.recipe
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end