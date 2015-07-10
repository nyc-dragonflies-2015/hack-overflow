require 'faker'

FactoryGirl.define do
 factory :question do
   title Faker::Lorem.sentence
   body  Faker::Lorem.paragraph
   user
   view_count 0
 end
end
