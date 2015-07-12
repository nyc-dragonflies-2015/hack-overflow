class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.commentable_type == 'Question'
      @question = Question.find(@comment.commentable_id)
      username = User.find(current_user.id).username
      data = {comment: @comment, username: username}
    elsif @comment.commentable_type == 'Answer'
      @answer = Answer.find(@comment.commentable_id)
      username = User.find(current_user.id).username
      data = {comment: @comment, username: username}
    end
    if @comment.save
      render json: data.to_json
    else
      flash[:alert] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.assign_attributes(comment_params)
    if @comment.save
      flash[:notice] = "Comment updated successfully."
      redirect_to :back
    else
      flash[:alert] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :commentable_type, :commentable_id)
  end

end
