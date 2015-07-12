require 'rails_helper'

describe TagsController do
  context '#create' do
    let(:user) { FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question, user_id: user.id)}
    before(:each) do
      request.env["HTTP_REFERER"] = "/questions/" + question.id.to_s
    end

    it 'should create a new tag' do
      expect{
        post :create, tag: {name: "Hello"}
      }.to change(Tag, :count).by(1)
    end

    it 'should have an association with a question' do
      question.tags << FactoryGirl.create(:tag, name: "HI")
      expect(question.tags.last.name).to eq("HI")
    end
  end
end
