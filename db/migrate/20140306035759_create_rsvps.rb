class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.references :event, index: true
      t.references :invitation, index: true
      t.boolean :attending

      t.timestamps
    end
  end
end
