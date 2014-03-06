class Rsvp < ActiveRecord::Base
  belongs_to :event
  belongs_to :invitation

  scope :yeses, -> { where(attending: true) }
  scope :nos, -> { where(attending: false) }

  scope :wedding, -> { joins(:event).where(events: { title: "wedding" }) }
  scope :rehearsal, -> { joins(:event).where(events: { title: "rehearsal" }) }
  scope :brunch, -> { joins(:event).where(events: { title: "brunch" }) }
end
