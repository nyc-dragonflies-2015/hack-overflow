require 'rails_helper'

describe Vote do
  let(:comment) {FactoryGirl.create(:comment)}
  let(:question) {FactoryGirl.create(:question)}
  let(:answer) {FactoryGirl.create(:answer)}
  it 'should respond to Votable' do
    expect(Vote.create(value: 1, votable_id: question.id, votable_type: "Question")).to be_valid
  end

  it 'should not accept an invalid value' do
    expect(Vote.create(value: "hello", votable_id: question.id, votable_type: "Question")).to_not be_valid
  end

  it 'should save if given valid params' do
    expect(Vote.create(value: -1, votable_id: comment.id, votable_type: "Comment")).to be_valid
  end
end
