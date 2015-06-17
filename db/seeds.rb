# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# creating users (without apps)
5.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    picture: 'http://lorempixel.com/30/30/people')
  password = Faker::Internet.password(8)
  Account.create(email: Faker::Internet.email,
    password: password,
    password_confirmation: password,
    user: user)
end

# creating owners with places
3.times do
  owner = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    picture: 'http://lorempixel.com/30/30/people')
  password = Faker::Internet.password(8)
  Account.create(email: Faker::Internet.email,
    password: password,
    password_confirmation: password,
    user: owner)
  2.times do
    Appartment.create(
    address: Faker::Address.street_address + Faker::Address.city,
    property_type: %w(Apartment House Room).sample,
    nbr_rooms: (1..5).to_a.sample,
    capacity: (1..12).to_a.sample,
    owner: owner,
    picture: 'http://lorempixel.com/30/30/city')
  end
end
