class Invitation < ActiveRecord::Base
  has_many :guests
  has_many :rsvps
end
