class Invitation < ActiveRecord::Base

  after_create :set_external_id

  has_many :guests
  has_many :rsvps, -> { order(event_id: :asc) }

  validates :name, uniqueness: true

  accepts_nested_attributes_for :guests, allow_destroy: true
  accepts_nested_attributes_for :rsvps

  def is_coming?
    self.rsvps.pluck(:attending).include?(true)
  end

  private

  def set_external_id
    self.update_attribute :external_id, SecureRandom.urlsafe_base64
  end
end
