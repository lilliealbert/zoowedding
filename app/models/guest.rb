class Guest < ActiveRecord::Base
  belongs_to :invitation

  validates :email, uniqueness: true
end
