class AddPriceRemoveEmailfromAppartment < ActiveRecord::Migration
  def change
    add_column :appartments, :price, :integer
    remove_column :users, :email_address
  end
end
