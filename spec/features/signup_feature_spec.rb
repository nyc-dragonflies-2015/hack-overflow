require 'rails_helper'

# spec/features/user_creates_a_foobar_spec.rb

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
end
