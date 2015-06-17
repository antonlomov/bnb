class Booking < ActiveRecord::Base
  belongs_to :appartment
  belongs_to :user
  # validates :start_date, presence: true, date: { after_or_equal_to: Proc.new { Date.today }, message: "must be at least #{(Date.today + 1).to_s}" }
  # validates :end_date, presence: true, date: { :after_or_equal_to => :start_date, message: "must be after the starting date" }
end
