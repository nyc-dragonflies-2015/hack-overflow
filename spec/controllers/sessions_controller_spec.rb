require 'rails_helper'

describe SessionsController do
  context '#create' do
    before(:each) do
      request.env["HTTP_REFERER"] = "/login/"
    end
    it 'should login a registered user' do
      user = FactoryGirl.create(:user)
      post :create, user: {email: user.email, password: user.password, username: user.username}
      expect(flash[:notice]).to eq(["Signed in successfully."])
    end

    it 'should not login an unregistered user' do
      post :create, user: {email: "example@example.com", password: "password", username: "MyName"}
      expect(flash[:alert]).to eq(["There was an error with your login request."])
    end

    it 'should display error messages if the form is not properly filled out' do
      user = FactoryGirl.create(:user)
      post :create, user: {email: user.email, password: user.password}
      expect(flash[:alert]).to eq(["There was an error with your login request."])
    end
  end
end
