class User < ActiveRecord::Base
  has_many :appartments
  has_many :bookings
  has_one :account

  with_options on: :update do |user|
    user.validates :first_name, :last_name, presence: true
    user.validates :first_name, uniqueness: { scope: :last_name }
  end

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  # after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end

end
