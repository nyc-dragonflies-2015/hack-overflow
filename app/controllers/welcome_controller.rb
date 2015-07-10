class WelcomeController < ApplicationController
 def index
  @user = User.new
  @questions = Question.all
  @questions = @questions.created_at.order("created_at DESC")
  end
end