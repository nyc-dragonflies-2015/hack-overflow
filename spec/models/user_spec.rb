require 'rails_helper'

describe User do
  context 'not logged in --' do
    it 'should save a valid user' do
      expect(FactoryGirl.create(:user)).to be_valid
    end

    it 'should not save a user without a username' do
      expect(FactoryGirl.build(:user, username: nil)).to_not be_valid
    end

    it 'should not save a user without an email' do
      expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
    end

    it 'should not save a user without a password' do
      expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
    end

    it 'should not save with an invalid email' do
      expect(FactoryGirl.build(:user, email: "nothing")).to_not be_valid
    end

    it 'should limit usernames to 20 characters' do
      expect(FactoryGirl.build(:user, username: "lllllllllllllllllllllllll")).to_not be_valid
    end
  end

  context "Registered User" do
    it 'should respond to Questions' do
      expect(FactoryGirl.create(:user)).to respond_to :questions
    end

    it 'should respond to Answers' do
      expect(FactoryGirl.create(:user)).to respond_to :answers
    end

    it 'should respond to Comments' do
      expect(FactoryGirl.create(:user)).to respond_to :comments
    end

    it 'should respond to Votes' do
      expect(FactoryGirl.create(:user)).to respond_to :votes
    end

  end
end
