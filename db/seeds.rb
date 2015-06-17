# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


PROPERTY_TYPES = %w(Apartment House Room)
ROOM_NUMBERS = (1..5).to_a
CAPACITIES = (1..12).to_a

# creating users (without apps)
5.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    picture: 'http://lorempixel.com/30/30/people')
  Account.create(
    email: Faker::Internet.email,
    encrypted_password: Faker::Internet.password(8),
    user: user)
end

# creating owners with places
3.times do
  owner = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    )
  Account.create(
    email: Faker::Internet.email,
    encrypted_password: Faker::Internet.password(8),
    user: owner
    )
  2.times do
    Appartment.create(
    address: Faker::Address.street_address + Faker::Address.city,
    property_type: PROPERTY_TYPES.sample,
    nbr_rooms: ROOM_NUMBERS.sample,
    capacity: CAPACITIES.sample,
    owner: owner,
    picture: 'http://lorempixel.com/30/30/city')
  end
end
