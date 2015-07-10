require 'faker'


FactoryGirl.define do
 factory :comment do
   body  Faker::Lorem.sentence
   user
   association :commentable, :factory => :question
  end
end
