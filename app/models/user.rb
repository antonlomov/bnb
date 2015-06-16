class User < ActiveRecord::Base
  has_many :appartments
  has_one :account
  validates :first_name, :last_name, presence: true
  validates :first_name, uniqueness: { scope: :last_name }
end
