class Meetup < ActiveRecord::Base
  has_many :rsvps
  has_many :users, through: :rsvps

  validates :title,
  presence: true

  validates :location,
  presence: true

  validates :description,
  presence: true

end
