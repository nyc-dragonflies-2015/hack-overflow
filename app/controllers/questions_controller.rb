class QuestionsController < ActionController::Base

  def index
    @question = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def create
    @question = Question.new(question_params)
    if @item.save
      redirect_to questions_path
    end

  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.assign_attributes(question_params)
    if @question.save
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "Question has been deleted"
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :view_count, :user_id)
  end

end