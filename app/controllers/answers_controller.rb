class AnswersController < ApplicationController

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      username = User.find(@answer.user.id).username
      data = {answer: @answer, username: username}
      render json: data.to_json
    else
      render json: {error: "Didn't work"}.to_json
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:body, :question_id, :user_id)
    end

end