 require 'faker'

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end
  sequence :username do |n|
    Faker::Name.name + "#{n}"
  end
  factory :user do
    username
    password "password"
    email
  end
end
