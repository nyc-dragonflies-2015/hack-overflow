class AnswersController < ApplicationController

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @question = Question.find(answer_params[:question_id])
    @answer.question_id = @question.id
    if @answer.save
      render json: @comment.to_json
    else
      redirect_to :back
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:body, :question_id, :user_id)
    end

end