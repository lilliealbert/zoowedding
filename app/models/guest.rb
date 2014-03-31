class Guest < ActiveRecord::Base
  belongs_to :invitation

  validates :email, uniqueness: true, allow_blank: true, allow_nil: true

  scope :with_email, -> { where.not(email: nil)}
end
