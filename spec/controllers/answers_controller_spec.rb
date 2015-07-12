require 'rails_helper'

describe AnswersController do
  context '#create' do

    let(:user) {FactoryGirl.create(:user)}
    let(:question) {FactoryGirl.create(:question, user_id: user.id)}
    before(:each) do
      request.env["HTTP_REFERER"] = "/questions/" + question.id.to_s
    end
    it 'should create a new answer' do
      id = question.id
      session[:user_id] = user.id
      expect{
        post :create, answer: FactoryGirl.attributes_for(:answer, user_id: user.id, question_id: question.id)
      }.to change(Answer, :count).by(1)
    end

    it 'should render the correct error messages when invalid' do
      session[:user_id] = user.id
      post :create, answer: FactoryGirl.attributes_for(:answer, body: nil, user_id: user.id, question_id: question.id )
      expect(flash[:alert]).to eq(["Body can't be blank"])
    end
  end

  context '#update' do
    let(:user) {FactoryGirl.create(:user)}
    let(:question) {FactoryGirl.create(:question, user_id: user.id)}
    before(:each) do
      request.env["HTTP_REFERER"] = "/questions/" + question.id.to_s
    end
    it 'should update the comment' do
      session[:user_id] = user.id
      id = question.id
      body = "Hello"
      answer = FactoryGirl.create(:answer, user_id: user.id, body: body)
      put :update, id: answer.id, answer: FactoryGirl.attributes_for(:answer, user_id: id, question_id: question.id, body: "Hey")
      expect(Answer.find_by(id: answer.id).body).to_not eq("Hello")
    end
  end

  context '#destroy' do
    let(:user) {FactoryGirl.create(:user)}
    let(:question) {FactoryGirl.create(:question, user_id: user.id)}
    before(:each) do
      request.env["HTTP_REFERER"] = "/questions/" + question.id.to_s
    end
    it 'should delete the comment' do
      session[:user_id] = user.id
      id = question.id
      answer = FactoryGirl.create(:answer, user_id: user.id, question_id: question.id)
      delete :destroy, id: answer.id
      expect(Answer.find_by(id: answer.id)).to eq(nil)
    end
  end
end
