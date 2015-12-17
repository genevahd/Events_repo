class Event < ActiveRecord::Base
  belongs_to :user
  has_many :joins, dependent: :destroy
  has_many  :comments, dependent: :destroy
  has_many :users_joined, through: :joins, source: :user
  validates :name, :date, :city, presence: true
  validates :state, presence: true, length: { is: 2 }
  validate :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past
    errors.add(:date, "cannot be in the past") if
      !date.blank? and date < Date.today
  end
end
