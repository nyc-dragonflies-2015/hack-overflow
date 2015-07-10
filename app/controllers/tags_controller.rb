class TagsController < ActionController::Base

  # def index
  #   @question = Question.all
  # end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    if @question.save
    @tag = Tag.new(tag_params)
      redirect_to questions_path
    end
  end

  # def edit
  #   @question = Question.find(params[:id])
  # end

  # def update
  #   @question = Question.find(params[:id])
  #   @question.assign_attributes(question_params)
  #   if @question.save
  #     redirect_to @question
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @question = Question.find(params[:id])
  #   @question.destroy
  #   flash[:notice] = "Question has been deleted"
  #   redirect_to questions_path
  # end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end