class CommentsController < ApplicationController
  def create
    @tip = Tip.find(params[:tip_id])
    @comment = @tip.comments.create(comment_params.merge({user_id: current_user.id}))
    redirect_to tip_path(@tip)
  end

  private
  def comment_params
    params.require(:comment).permit(:tip_id, :content)
  end
end
