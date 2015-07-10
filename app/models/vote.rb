class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :value, presence: true
  validates :user, presence: true
  validates :voteable, presence: true

end
