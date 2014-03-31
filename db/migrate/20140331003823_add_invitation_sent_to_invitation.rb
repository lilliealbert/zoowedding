class AddInvitationSentToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :sent_at, :timestamp
  end
end
