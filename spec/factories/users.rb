 require 'faker'
 
FactoryGirl.define do
  factory :user do
    username "John"
    email  "john@example.com"
    password "password"
  end
