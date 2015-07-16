class AnswersController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :update, :destroy]
  def create
    @answer = Answer.new(answer_params)
    # You can bolt this calculation onto answer_params using .merge()
    @answer.user_id = current_user.id
    if @answer.save
      username = User.find(@answer.user.id).username
      # Typically we see this being in-lined into the following line
      data = {answer: @answer, username: username}
      render json: data.to_json
    else
      flash[:alert] = @answer.errors.full_messages
      # Typically render is the last thing
      render json: {error: "Didn't work"}.to_json
      @answer.user_id = answer_params["user_id"] || current_user.id
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.assign_attributes(answer_params)
    if @answer.save
      flash[:notice] = "Answer successfully updated."
      # I dislike going :back, send me somewhere clear, please.  It's a style
      # thing but that's my opinion.
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
