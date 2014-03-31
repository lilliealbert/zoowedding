class Event < ActiveRecord::Base
  has_many :rsvps

  TITLES = ["rehearsal_dinner", "zoo_walk", "wedding", "brunch"]
end
