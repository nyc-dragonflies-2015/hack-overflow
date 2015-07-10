class Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :view_count, prescence: true
  validates :body, presence: true
  validates :user, presence: true

end
