class Rsvp < ActiveRecord::Base
  belongs_to :event
  belongs_to :invitation

  scope :yeses, -> { where(attending: true) }
  scope :nos, -> { where(attending: false) }

  scope :wedding, -> { joins(:event).where(events: { title: "wedding" }) }
  scope :rehearsal_dinner, -> { joins(:event).where(events: { title: "rehearsal_dinner" }) }
  scope :brunch, -> { joins(:event).where(events: { title: "brunch" }) }
  scope :zoo_walk, -> { joins(:event).where(events: { title: "zoo_walk" }) }
end
