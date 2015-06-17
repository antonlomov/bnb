class User < ActiveRecord::Base
  has_many :appartments
  has_many :bookings
  has_one :account
  validates :first_name, :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/
end
