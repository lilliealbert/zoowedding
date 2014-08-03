class Guest < ActiveRecord::Base
  RELATIONSHIP_TYPES = ["lillie_family", "sf_friends", "travis_family", "oberlin", "lillie_friends", "travis_friends"]

  belongs_to :invitation

  validates :email, uniqueness: true, allow_blank: true, allow_nil: true

  scope :with_email, -> { where.not(email: nil)}

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |guest|
        csv << guest.attributes.values_at(*column_names)
      end
    end
  end
end
