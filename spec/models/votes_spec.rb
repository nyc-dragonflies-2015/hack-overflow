require 'rails_helper'

describe Vote do
  let(:comment) {FactoryGirl.create(:comment)}
  let(:question) {FactoryGirl.create(:question)}
  let(:answer) {FactoryGirl.create(:answer)}
  let(:user) {FactoryGirl.create(:user)}
  it 'should respond to Votable' do
    expect(Vote.create(value: 1, user_id: user.id, voteable_id: question.id, voteable_type: "Question")).to be_valid
  end

  it 'should not accept an invalid value' do
    expect(Vote.new(value: "hello", user_id: user.id, voteable_id: question.id, voteable_type: "Question")).to_not be_valid
  end

  it 'should save if given valid params' do
    expect(Vote.new(value: -1, user_id: user.id, voteable_id: comment.id, voteable_type: "Comment")).to be_valid
  end
end
