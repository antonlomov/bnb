class AddOwnerToAppartments < ActiveRecord::Migration
  def change
    add_reference :appartments, :owner, references: :user
  end
end
