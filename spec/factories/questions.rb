require 'faker'
require 'rails_helper'

FactoryGirl.define do
 factory :question do
   title Faker::Lorem.sentence
   body  Faker::Lorem.paragraph
   view_count 0
 end
end
