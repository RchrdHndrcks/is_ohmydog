# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(
  email: "pecotcheandres@outlook.com",
  password: "123456",
  name: "andres",
  last_name: "pecotche",
  phone_number: "2262653921",
  address: "70",
  identifier_number: 4134374,
  es_admin: true
)
puts "Se ha creado un usuario con los datos especificados en el archivo seeds.rb."