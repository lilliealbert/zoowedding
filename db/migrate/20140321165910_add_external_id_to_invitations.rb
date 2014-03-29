class AddExternalIdToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :external_id, :string
  end
end
