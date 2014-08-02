class AddShuttleToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :shuttle, :boolean
  end
end
