class Invitation < ActiveRecord::Base

  after_create :set_external_id

  has_many :guests
  has_many :rsvps

  validates :name, uniqueness: true
  private

  def set_external_id
    self.external_id = SecureRandom.urlsafe_base64
  end
end
