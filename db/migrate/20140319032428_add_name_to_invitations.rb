class AddNameToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :name, :string
  end
end
