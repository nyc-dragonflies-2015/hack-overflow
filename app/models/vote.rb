class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :value, presence: true, numericality: true
  validates :value, format: {:with => /1|-1/, message: "Must be value of 1 or -1"}
  validates :user, presence: true
  validates :voteable, presence: true

end
