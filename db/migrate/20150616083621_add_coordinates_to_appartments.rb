class AddCoordinatesToAppartments < ActiveRecord::Migration
  def change
    add_column :appartments, :latitude, :float
    add_column :appartments, :longitude, :float
  end
end
