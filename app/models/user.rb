class User < ActiveRecord::Base
  has_secure_password
  has_many :events
  has_many :comments, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :events_joined, through: :joins, source: :event
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, :last_name, :email, :city, presence: true, length: { in: 2..20 }
  validates :password, length: { in: 6..14 }, on: :create
  validates :state, presence: true, length: { is: 2 }
  validates :email, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
end
