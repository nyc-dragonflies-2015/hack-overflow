class AnswersController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :update, :destroy]
  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      username = User.find(@answer.user.id).username
      data = {answer: @answer, username: username}
      render json: data.to_json
    else
      flash[:alert] = @answer.errors.full_messages
      render json: {error: "Didn't work"}.to_json
      @answer.user_id = answer_params["user_id"] || current_user.id
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.assign_attributes(answer_params)
    if @answer.save
      flash[:notice] = "Answer successfully updated."
      redirect_to :back
    else
      flash[:alert] = @answer.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    flash[:notice] = "Answer successfully deleted."
    redirect_to :back
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id, :user_id)
  end
end
