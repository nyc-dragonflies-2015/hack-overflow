require 'rails_helper'

describe Comment do
  it 'should respond to User' do
    expect(FactoryGirl.create(:comment)).to respond_to :user
  end

  it 'should respond to Commentable' do
    expect(FactoryGirl.create(:comment)).to respond_to :commentable
  end

  it 'should respond to Tags' do
    expect(FactoryGirl.create(:comment)).to respond_to :tags
  end

  it 'should not save without a valid user' do
    expect(FactoryGirl.build(:comment, user_id: nil)).to_not be_valid
  end

  it 'should not save without a body' do
    expect(FactoryGirl.build(:comment, body: nil)).to_not be_valid
  end

  it 'should save if valid params' do
    expect(FactoryGirl.create(:comment)).to be_valid
  end
end
