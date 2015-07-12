class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id
      if @vote.voteable_type == 'Question'
        @question = Question.find(@vote.voteable_id)
     # get_vote_value
      elsif @vote.voteable_type == 'Answer'
        @answer = Answer.find(@vote.voteable_id)
     # get_vote_value
      elsif @vote.voteable_type == 'Comment'
        @comment = Comment.find(@vote.voteable_id)
     # get_vote_value
      end
      if @vote.save
        # redirect_to question_path(@vote.voteable_id)
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

    # def get_vote_value
    #   if params[:commit] == 'up'
    #     @vote[:value] = 1
    #   elsif params[:commit] == 'down'
    #     @vote[:value] = -1
    #   end
    # end

end