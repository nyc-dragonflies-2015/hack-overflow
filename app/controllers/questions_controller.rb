class QuestionsController < ApplicationController
  def index
    @question = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.all
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
    p @question
    @question.assign_attributes(question_params)
    if @question.save
      binding.pry
      redirect_to @question
    else
      redirect_to :back
    end
  end

  def destroy
    @question = Question.find(params[:id])
    authenticate_user!(@question.user_id)
    @question.destroy
    flash[:notice] = "Question has been deleted"
    redirect_to root_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :view_count, :user_id)
  end

end
