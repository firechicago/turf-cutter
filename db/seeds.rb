# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "csv"
if Rails.env == :development
  voters_data = CSV.read("db/seed_addresses.csv")

  voters_data.each do |voter_data|
    voter = Voter.new
    voter.address1 = voter_data[0]
    voter.address2 = voter_data[1]
    voter.city = voter_data[2]
    voter.state = voter_data[3]
    voter.zip = "0" + voter_data[4]
    voter.first_name = Faker::Name.first_name
    voter.last_name = Faker::Name.last_name
    voter.geocode
    puts "#{voter.full_name} created" if voter.save
  end
end
