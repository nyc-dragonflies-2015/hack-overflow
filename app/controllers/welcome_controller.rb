class WelcomeController < ApplicationController
  def index
    @user = User.new
    @questions = Question.all.order("created_at DESC")
  end
end