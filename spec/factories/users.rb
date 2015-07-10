 require 'faker'
 require 'rails_helper'

FactoryGirl.define do
  factory :user do
    username Faker::Name.name
    email  Faker::Internet.email
    password "password"
  end
end
