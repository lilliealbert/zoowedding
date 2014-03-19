class Invitation < ActiveRecord::Base
  has_many :guests
  has_many :rsvps

  validates :name, uniqueness: true
end
