require 'rails_helper'

describe QuestionsController do
  context '#new' do
    it 'should render a form to create a new question' do
      get :new
      expect(assigns(:question)).to be_a Question
    end
  end

  context '#create' do
    it 'should create a new question in the database' do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      expect{
        post :create, question: FactoryGirl.attributes_for(:question, user_id: user.id)
      }.to change(Question, :count).by(1)
    end

    it 'should not save an invalid question' do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      expect{
        post :create, question: FactoryGirl.attributes_for(:question, user_id: nil)
      }.to change(Question, :count).by(0)
    end

    it 'should render the proper error messages' do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      post :create, question: FactoryGirl.attributes_for(:question, title: nil, user_id: user.id)
      expect(flash[:alert]).to eq(["Title can't be blank"])
    end
  end

  context '#edit' do
    it 'should allow the user to edit their own question' do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id
      question = FactoryGirl.create(:question)
      get :edit, id: question.id
      expect(assigns(:question)).to be_a Question
    end

    it 'should not allow a user who is not the author to edit the question' do
      user = FactoryGirl.create(:user)
      secondUser = FactoryGirl.create(:user)
      question = FactoryGirl.create(:question, user_id: secondUser.id)
      session[:user_id] = user.id
      get :edit, id: question.id
      expect(response).to redirect_to(root_path)
    end
  end

  context '#update' do
    it 'should update the question in the database if the params are valid' do
      user = FactoryGirl.create(:user)
      question = FactoryGirl.create(:question, user_id: user.id, body: "Hello")
      id = question.id
      session[:user_id] = user.id
      put :update, id: question.id, question: FactoryGirl.attributes_for(:question, user_id: user.id)
      expect(Question.find(id).body).to_not eq("Hello")
    end

    it 'should render the proper error messages if the params are not valid' do
      user = FactoryGirl.create(:user)
      question = FactoryGirl.create(:question, user_id: user.id)
      session[:user_id] = user.id
      put :update, id: question.id, question: FactoryGirl.attributes_for(:question, body: nil)
      expect(flash[:alert]).to eq(["Body can't be blank"])
    end
  end

  context '#destroy' do
    it 'should delete the question from the database if the current user is the author of the question' do
      user = FactoryGirl.create(:user)
      question = FactoryGirl.create(:question, user_id: user.id)
      session[:user_id] = user.id
      delete :destroy, id: question.id
      expect(response).to redirect_to root_path
      expect(Question.find_by(id: question.id)).to eq(nil)
    end

    it 'should not allow an unauthorized user to delete the question' do
      user = FactoryGirl.create(:user)
      question = FactoryGirl.create(:question, user_id: user.id)
      session[:user_id] = nil
      delete :destroy, id: question.id
      expect(Question.find_by(id: question.id)).to_not eq(nil)
    end
  end

  context '#show' do
    let(:user) { FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question, user_id: user.id) }
    it 'should display the question along with its answers' do
      get :show, id: question.id
      expect(assigns(:question)).to be_a Question
      expect(assigns(:answers)).to be_a ActiveRecord::AssociationRelation
    end

    it 'should display the comments for the question' do
      get :show, id: question.id
      expect(assigns(:question_comments)).to be_a ActiveRecord::AssociationRelation
    end
  end
end
