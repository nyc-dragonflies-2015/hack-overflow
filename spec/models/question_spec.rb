require 'rails_helper'

describe Question do
  it 'should respond to User' do
    expect(FactoryGirl.create(:question)).to respond_to :user
  end

  it 'should respond to Comments' do
    expect(FactoryGirl.create(:question)).to respond_to :comments
  end

  it 'should respond to Answers' do
    expect(FactoryGirl.create(:question)).to respond_to :answers
  end

  it 'should respond to Votes' do
    expect(FactoryGirl.create(:question)).to respond_to :votes
  end

  it 'should not save without a valid user' do
    expect(FactoryGirl.build(:question, user_id: nil)).to_not be_valid
  end

  it 'should not save without a title' do
    expect(FactoryGirl.build(:question, title: nil)).to_not be_valid
  end

  it 'should not save without a body' do
    expect(FactoryGirl.build(:question, body: nil)).to_not be_valid
  end

  it 'should respond to Tags' do
    expect(FactoryGirl.create(:question)).to respond_to :tags
  end
end
