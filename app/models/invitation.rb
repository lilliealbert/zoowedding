class Invitation < ActiveRecord::Base

  after_create :set_external_id

  has_many :guests
  has_many :rsvps

  validates :name, uniqueness: true

  accepts_nested_attributes_for :guests, allow_destroy: true
  accepts_nested_attributes_for :rsvps

  private

  def set_external_id
    self.external_id = SecureRandom.urlsafe_base64
  end
end
