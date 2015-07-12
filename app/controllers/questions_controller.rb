class QuestionsController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :update, :destroy]
  def index
    @question = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.all
    @comment = Comment.new
    @answer = Answer.new
    @answers = @question.answers.all.order("created_at DESC")
    @question_comments = @question.comments.all.order("created_at DESC")
    @question.increment!(:view_count)
    @vote = Vote.new #add for votes
    @vote_count = @question.votes.pluck(:value).reduce(:+) || 0
  end

  def new
    require_logged_in
    @question = Question.new
  end

  def create
    require_logged_in
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
    else
      flash[:alert] = @question.errors.full_messages
      redirect_to root_path
    end
  end

  def edit
    @question = Question.find(params[:id])
    authenticate_user!(@question.user_id)
  end

  def update
    @question = Question.find(params[:id])
    @question.assign_attributes(question_params)
    if @question.save
      redirect_to @question
    else
      flash[:alert] = @question.errors.full_messages
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if current_user && session[:user_id] == current_user.id
      @question.destroy
      flash[:notice] = "Question has been deleted"
    end
    redirect_to root_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :view_count, :user_id)
  end

end
