class Appartment < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode
  PROPERTY_TYPES = %w(Apartment House Room)
  ROOM_NUMBERS = (1..5).to_a
  CAPACITIES = (1..12).to_a
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many :bookings, dependent: :restrict_with_exception
  has_many :availability_periods, dependent: :destroy
  validates :address, :city, :property_type, :nbr_rooms, :capacity, :owner_id, presence: true
  validates :property_type, inclusion: { in: PROPERTY_TYPES, message: "%{value} is not a valid property type" }
  validates :nbr_rooms, inclusion: { in: ROOM_NUMBERS, message: "%{value} is not in the range of room numbers" }, numericality: { only_integer: true }
  validates :capacity, inclusion: { in: CAPACITIES, message: "%{value} is not in the range of capacities" }, numericality: { only_integer: true }
  validates :price, numericality: true, presence: true
  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  def self.find_apps_for_owner(current_user_id)
    apps = Appartment.where("owner_id = #{current_user_id}")
  end
end

