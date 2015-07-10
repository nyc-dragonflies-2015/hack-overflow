require 'faker'

FactoryGirl.define do
 factory :answer do
   body  Faker::Lorem.paragraph
   user
 end
end
