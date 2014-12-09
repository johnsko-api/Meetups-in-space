class Meetup < ActiveRecord::Base

  validates :title,
  presence: true

  validates :location,
  presence: true

  validates :description,
  presence: true

end
