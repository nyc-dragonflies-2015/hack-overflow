class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id
      if @vote.voteable_type == 'Question'
        @data = Question.find(@vote.voteable_id)
      elsif @vote.voteable_type == 'Answer'
        @data = Answer.find(@vote.voteable_id)
      elsif @vote.voteable_type == 'Comment'
        @data = Comment.find(@vote.voteable_id)
      end
      if @vote.save
        render json: @data.votes.pluck(:value).reduce(:+).to_json
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