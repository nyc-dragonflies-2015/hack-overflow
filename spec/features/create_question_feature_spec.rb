require 'rails_helper'

def login(id)
  visit root_path
  click_link 'Sign-Up'
  fill_in 'Username', :with => "Bill#{id}"
  fill_in 'Email', :with => 'bill@example.com'
  fill_in 'Password', :with => 'password'
  click_button 'Create'
end

feature 'create a question' do
  scenario 'signed in' do
    login(1)
    click_link 'Add New Question'
    fill_in 'Title', :with => 'Title'
    fill_in 'Body', :with => 'Body'
    click_button 'Create'
    expect(page).to have_content 'Title: Title'
  end

  scenario 'not signed in' do
    visit root_path
    expect(page).to_not have_content 'Add New Question'
  end
end
