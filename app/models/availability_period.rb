class AvailabilityPeriod < ActiveRecord::Base
  belongs_to :appartment
  validates :start_date, :end_date, presence: true
  validate :start_date_before_end_date
  validate :start_date_cannot_be_in_the_past

  def start_date_before_end_date
    if start_date > end_date
      errors.add(:start_date, "Start date should be before end date")
    end
  end

  def start_date_cannot_be_in_the_past
    if start_date < Date.today
      errors.add(:start_date, "Dates can't be in the past")
    end
  end

end
