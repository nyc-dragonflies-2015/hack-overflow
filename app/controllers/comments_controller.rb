class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    # if @comment.save
      if @comment.commentable_type == 'Question'
        @question = Question.find(@comment.commentable_id)
        @comment.question_id = @question.id
        @question.comments << @comment.save
        render json: @comment.to_json
      elsif @comment.commentable_type == 'Answer'
        @answer = Answer.find(@comment.commentable_id)
        @comment.question_id = @question.id
      end
      if @comment.save
        render json: @comment.to_json
      else
       ## redirect
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :commentable_type, :commentable_id)
  end

end
