class Booking < ActiveRecord::Base
  belongs_to :appartment
  belongs_to :user
  validates :start_date, :end_date, presence: true
  validate :start_date_before_end_date
  validate :start_date_cannot_be_in_the_past
  # validates :start_date, presence: true, date: { after_or_equal_to: Proc.new { Date.today }, message: "must be at least #{(Date.today + 1).to_s}" }
  # validates :end_date, presence: true, date: { :after_or_equal_to => :start_date, message: "must be after the starting date" }

  after_create :send_booking_confirmation_email



  def start_date_before_end_date
    if start_date > end_date
      errors.add(:start_date, "Check-in date should be before check-out date")
    end
  end

  def start_date_cannot_be_in_the_past
    if start_date < Date.today
      errors.add(:start_date, "Dates can't be in the past")
    end
  end

  private

  def send_booking_confirmation_email
    UserMailer.confirm_booking(self).deliver
  end


end
