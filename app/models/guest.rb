class Guest < ActiveRecord::Base
  belongs_to :invitation
end
