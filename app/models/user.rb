class User < ActiveRecord::Base

  has_many :appartments
  has_one :account

end
