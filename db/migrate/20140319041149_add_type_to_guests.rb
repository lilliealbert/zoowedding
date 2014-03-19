class AddTypeToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :relationship_type, :string
  end
end
