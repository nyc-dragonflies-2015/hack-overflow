require 'rails_helper'

def create_user
  @user ||= create(:user)
end

def login(id)
  visit root_path
  click_link 'Sign-Up'
  fill_in 'Username', :with => "John#{id}"
  fill_in 'Email', :with => 'john@example.com'
  fill_in 'Password', :with => 'password'
  click_button 'Create'
end

feature 'question#show' do
  scenario 'visit a question' do
    question = FactoryGirl.create(:question, user_id: User.first.id)
    login(1)
    find('a[href="/questions/1"]').click
    expect(page).to have_content 'Add Comment'
  end
  
  scenario 'add a comment' do
    question = FactoryGirl.create(:question, user_id: User.first.id)
    login(2)
    find('a[href="/questions/7"]').click
    find('#question-comment-button').click
    find('#comment_body', :visible => false).set("Nice question!")
    find('#question_comment_submit', :visible => false).click
    expect(page).to have_content 'Nice question!'
  end
end
