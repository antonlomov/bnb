class CreateAppartments < ActiveRecord::Migration
  def change
    create_table :appartments do |t|
      t.string :address
      t.string :property_type
      t.integer :nbr_rooms
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
