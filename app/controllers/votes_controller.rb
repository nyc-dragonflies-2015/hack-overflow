class VotesController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :update, :destroy]
  def new
    @vote = Vote.new
  end

  # Obviously this could be really heavily refactored....
  # As a baseline methods should be about 5-10 lines...
  def create
    @old_vote = Vote.find_by(user_id: current_user.id, voteable_id: vote_params["voteable_id"], voteable_type: vote_params["voteable_type"])
    if @old_vote && @old_vote.value != vote_params["value"]
      @old_vote.destroy
    end
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
       redirect_to root_path
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
