class AddReferencesToBooking < ActiveRecord::Migration
  def change
    add_reference :bookings, :user, index: true
    add_reference :bookings, :appartment, index: true
  end
end
