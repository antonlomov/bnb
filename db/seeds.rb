# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# creating owners with places and availability periods for those places
2.times do
  password = Faker::Internet.password(8)
  account = Account.create(
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password,
    user: User.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_number: Faker::PhoneNumber.cell_phone
      # picture: 'http://lorempixel.com/30/30/people'
      )
    )
  1.times do
    appartment = Appartment.create(
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      property_type: %w(Apartment House Room).sample,
      nbr_rooms: (1..5).to_a.sample,
      capacity: (1..12).to_a.sample,
      owner: account.user,
      price: (20..200).to_a.sample
      # picture: 'http://lorempixel.com/30/30/nature'
      )
    4.times do
      start_date = Faker::Date.forward(365)
      end_date = Faker::Date.between(start_date, Date.today + 366)
      AvailabilityPeriod.create(
        start_date: start_date,
        end_date: end_date,
        appartment: appartment
        )
    end
  end
end



