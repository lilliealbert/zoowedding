class Guest < ActiveRecord::Base
  RELATIONSHIP_TYPES = ["lillie_family", "sf_friends", "travis_family", "oberlin", "lillie_friends", "travis_friends"]

  belongs_to :invitation

  validates :email, uniqueness: true, allow_blank: true, allow_nil: true

  scope :with_email, -> { where.not(email: nil)}
end
