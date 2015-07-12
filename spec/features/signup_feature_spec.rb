require 'rails_helper'

feature 'signup' do
  scenario 'register new user' do
    visit root_path
    click_link 'Sign-Up'
    fill_in 'Username', :with => 'John'
    fill_in 'Email', :with => 'john@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Create'
    expect(page).to have_content "Logout"
  end

  scenario 'logout' do
    user = FactoryGirl.create(:user)
    page.set_rack_session(user_id: user.id)
    visit root_path
    click_link 'Logout'
    expect(page).to have_content 'Sign-Up'
  end

  scenario 'login', js: true do
    visit root_path
    click_link 'Sign-Up'
    fill_in 'Username', :with => 'John'
    fill_in 'Email', :with => 'john@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Create'
    click_link 'Logout'
    find('#user_username').set('John')
    find('#user_password').set("password")
    page.execute_script("$('form#new_user').submit()")
    expect(page).to have_content 'Logout'
  end
end
