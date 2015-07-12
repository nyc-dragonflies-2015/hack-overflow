require 'rails_helper'

def login(id="")
  visit root_path
  click_link 'Sign-Up'
  fill_in 'Username', :with => "Sam#{id}"
  fill_in 'Email', :with => 'sam@example.com'
  fill_in 'Password', :with => 'password'
  click_button 'Create'
end

feature 'user account' do
  scenario 'edit registered account' do
    login(1)
    click_link 'Edit Account'
    fill_in 'Username', :with => 'Walrus'
    fill_in 'Password', :with => 'password'
    click_button 'Update Your Account'
    expect(page).to have_content 'Logged in as: Walrus'
  end

  scenario 'delete account' do
    login(2)
    click_link 'Edit Account'
    click_link 'Delete Account'
    expect(page).to_not have_content 'Logged in as:'
  end
end
