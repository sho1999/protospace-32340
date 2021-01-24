class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype_id
      #@comments = @prototype.comment
      render "prototypes/show"
    end
  end

  def create
    comment = Comment.create(comment_params)
    redirect_to "/prototypes/#{comment.prototype.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end 
end
