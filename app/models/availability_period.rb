class AvailabilityPeriod < ActiveRecord::Base
  belongs_to :appartment
  validates :start_date, :end_date, presence: true
end
