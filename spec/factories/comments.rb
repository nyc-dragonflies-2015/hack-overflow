require 'faker'

FactoryGirl.define do
 factory :comment do
   body  Faker::Lorem.sentence
   user
 end
end
