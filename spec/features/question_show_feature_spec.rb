require 'rails_helper'

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
    login(1)
    find('a[href="/questions/1"]').click
    expect(page).to have_content 'Add Comment'
  end

  scenario 'add a comment for a question' do
    login(2)
    find('a[href="/questions/7"]').click
    find('#question-comment-button').click
    find('#comment_body', :visible => false).set("Nice question!")
    find('#question_comment_submit', :visible => false).click
    visit '/questions/7'
    expect(page).to have_content 'Nice question!'
  end

  scenario 'add an answer for a question' do
    login(3)
    find('a[href="/questions/13"]').click
    find('#question-comment-button').click
    find('#comment_body', :visible => false).set("Nice question!")
    find('#question_comment_submit', :visible => false).click
    visit '/questions/13'
    find('#answer-button').click
    find('#answer_body', :visible => false).set("This is my answer")
    save_and_open_page
    find('#answer-submit', :visible => false).click
    visit '/questions/13'
    save_and_open_page
    expect(page).to have_content 'This is my answer'
  end

  scenario 'add a comment for an answer' do
    login(4)
    find('a[href="/questions/19"]').click
    find('#question-comment-button').click
    find('#answer-button').click
    find('#answer_body', :visible => false).set("This is my answer")
    find('#answer-submit', :visible => false).click
    visit '/questions/19'
    find('#answer-comment-button-2').click
    find('.answer-comment-form #comment_body', :visible => false).set("Nice answer!")
    find('.answer-comment-form input[type=submit]', :visible => false).click
    visit '/questions/19'
    save_and_open_page
    expect(page).to have_content 'Nice answer!'
  end
end
