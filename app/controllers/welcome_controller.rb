class WelcomeController < ApplicationController
 def index
  @user = User.new
  @question = Question.all
  end
end