require 'rails_helper'

def login(id="") ## helper method to avoid duplicate accounts in running tests
  visit root_path
  click_link 'Sign-Up'
  fill_in 'Username', :with => "Tom#{id}"
  fill_in 'Email', :with => 'tom@example.com'
  fill_in 'Password', :with => 'password'
  click_button 'Create'
end

feature 'voting' do
  scenario 'upvote a question' do
    login(1)
    id = Question.first.id
    find('a[href="/questions/'+ id.to_s + '"]').click
    find('form#up-vote input[type=submit]').click
    visit '/questions/' + id.to_s
    expect(page).to have_content 'Vote count: 1'
  end

  scenario 'downvote a question' do
    login(2)
    id = Question.first.id
    find('a[href="/questions/'+ id.to_s + '"]').click
    find('form#down-vote input[type=submit]').click
    visit '/questions/' + id.to_s
    expect(page).to have_content 'Vote count: -1'
  end
end
