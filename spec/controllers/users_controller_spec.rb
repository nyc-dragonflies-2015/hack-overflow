require 'rails_helper'

describe UsersController do
  context "#new" do
    it 'should render a registration form to the visitor' do
      get :new
      expect(assigns(:user)).to be_a User
    end
  end

  context '#create' do
    it 'should create a new user' do
      post :create, user: FactoryGirl.attributes_for(:user)
      expect(session[:user_id]).to_not eq(nil)
    end

    it 'should not create a user with invalid attributes' do
      post :create, user: FactoryGirl.attributes_for(:user, username: nil)
      expect(session[:user_id]).to eq(nil)
    end

    it 'should redirect to the root path if successful' do
      post :create, user: FactoryGirl.attributes_for(:user)
      expect(response).to redirect_to(root_url)
    end

    it 'should display error messages if no username is provided' do
      post :create, user: FactoryGirl.attributes_for(:user, username: nil)
      expect(flash[:alert]).to eq(["Username can't be blank"])
    end
  end

  context '#edit' do
    it 'should allow the user to edit their account information' do
      user = FactoryGirl.create(:user)
      get :edit, id: user.id
      expect(assigns(:user)).to be_a User
    end
  end

  context '#update' do
    it 'should save the changes of the user account to the database' do
      user = FactoryGirl.create(:user)
      username = user.username
      post :update, id: user.id, user: FactoryGirl.attributes_for(:user)
      expect(User.find(user.id)).to_not eq(username)
    end
  end

  context 'destroy' do
    it 'should delete the users account' do
      user = FactoryGirl.create(:user)
      delete :destroy, id: user.id
      expect(session[:user_id]).to eq(nil)
      expect(User.find_by(id: user.id)).to eq(nil)
    end
  end
end
