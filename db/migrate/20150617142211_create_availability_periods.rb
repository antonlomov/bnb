class CreateAvailabilityPeriods < ActiveRecord::Migration
  def change
    create_table :availability_periods do |t|
      t.date :start_date
      t.date :end_date
      t.references :appartment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
