class VotesController < ApplicationController

  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id
      if @vote.voteable_type == 'Question'
        @question = Question.find(@vote.voteable_id)
        @vote.question_id = @question.id
      elsif @vote.voteable_type == 'Answer'
        @answer = Answer.find(@vote.voteable_id)
        @vote.question_id = @question.id
      end
      if @vote.save
        render json: @vote.to_json
      else
       ## redirect
      end
  end

  def update
    @vote = Vote.find(params[:id])

    if @vote.update(vote_params)
      redirect_to :back
    else
      render :new
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    redirect_to :back
  end

  private

    def vote_params
      params.require(:vote).permit(:value, :user_id, :voteable_type, :voteable_id)
    end

end