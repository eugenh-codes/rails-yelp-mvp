# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "rest-client"
require "faker"

url = 'https://the-fork.api.lewagon.com/api/v1/restaurants'
response = RestClient.get url
repos = JSON.parse(response)

# p repos
phone = Faker::PhoneNumber.cell_phone_with_country_code

categories = %w[chinese italian japanese french belgian]
selected = repos.select { |repo| categories.include?(repo['category'])}

Restaurant.destroy_all
selected[0..4].each do |obj|
  obj = obj.transform_keys(&:to_sym)
  attributes = { name: obj[:name], address: obj[:address], phone_number: phone, category: obj[:category] }
  # p attributes
  Restaurant.create!(attributes)
  # puts `#{restaurant.name} created`
end
