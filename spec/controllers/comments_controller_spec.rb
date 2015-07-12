require 'rails_helper'

describe CommentsController do
  context '#create' do

    let(:user) {FactoryGirl.create(:user)}
    let(:question) {FactoryGirl.create(:question, user_id: user.id)}
    before(:each) do
      request.env["HTTP_REFERER"] = "/questions/" + question.id.to_s
    end
    it 'should create a new comment' do
      id = question.id
      session[:user_id] = user.id
      expect{
        post :create, comment: FactoryGirl.attributes_for(:comment, user_id: user.id, commentable_id: id, commentable_type: "Question")
      }.to change(Comment, :count).by(1)
    end

    it 'should render the correct error messages when invalid' do
      session[:user_id] = user.id
      post :create, comment: FactoryGirl.attributes_for(:comment, body: nil)
      expect(flash[:alert]).to eq(["Body can't be blank", "Commentable can't be blank"])
    end
  end

  context '#update' do
    it 'should update the comment' do
    end
  end

  context '#destroy' do
    it 'should delete the comment' do
    end
  end
end
