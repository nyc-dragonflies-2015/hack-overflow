require 'rails_helper'

describe Answer do
  it 'should respond to User' do
    expect(FactoryGirl.create(:answer)).to respond_to :user
  end

  it 'should respond to Question' do
    expect(FactoryGirl.create(:answer)).to respond_to :question
  end

  it 'should respond to Comments' do
    expect(FactoryGirl.create(:answer)).to respond_to :comments
  end

  it 'should respond to Votes' do
    expect(FactoryGirl.create(:answer)).to respond_to :votes
  end

  it 'should not save unless there is a User' do
    expect(FactoryGirl.build(:answer, user_id: nil)).to_not be_valid
  end

  it 'should not save unless there is a body' do
    expect(FactoryGirl.build(:answer, body: nil)).to_not be_valid
  end

  it 'should save if there is a valid user and body' do
    expect(FactoryGirl.create(:answer)).to be_valid
  end
end
