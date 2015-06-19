class AddCityToAppartments < ActiveRecord::Migration
  def change
    add_column :appartments, :city, :string
  end
end
