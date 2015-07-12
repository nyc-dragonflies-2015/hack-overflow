class TagsController < ApplicationController

  def index
    @tag = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "Tag successfully saved."
      render json: @tag.to_json
    else
      flash[:alert] = @tag.errors.full_messages
      render :new
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
