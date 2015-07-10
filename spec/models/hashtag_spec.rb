require 'rails_helper'

describe Tag do
  let(:question) {FactoryGirl.create(:question)}
  it 'should respond to Question' do
    question.tags << FactoryGirl.create(:tag, name: "hello")
    expect(question.tags.last.name).to eq("hello")
  end

  it 'should not save without a name' do
    expect(FactoryGirl.build(:tag, name: nil)).to_not be_valid
  end

  it 'should save with valid params' do
    expect(FactoryGirl.create(:tag)).to be_valid
  end
end
