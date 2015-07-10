require 'faker'
require 'rails_helper'

FactoryGirl.define do
 factory :tag do
   name  Faker::Lorem.word
 end
end
