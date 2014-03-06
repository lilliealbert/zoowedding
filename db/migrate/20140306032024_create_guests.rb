class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.string :email
      t.references :invitation

      t.timestamps
    end
  end
end
