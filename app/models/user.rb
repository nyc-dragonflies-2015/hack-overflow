class User < ActiveRecord::Base
  has_secure_password

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :votes

  validates :username, :email, uniqueness: true, presence: true, length: {maximum: 20}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password, presence: true
  validates :password, length: { minimum: 6 }

end
