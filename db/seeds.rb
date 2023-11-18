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

User.create(
  email: "matilugarzo@gmail.com",
  password: "123456",
  name: "Matias",
  last_name: "Lugarzo",
  phone_number: "2223501082",
  address: "70",
  identifier_number: 43595173,
  es_admin: true
  
)
puts "Se ha creado un usuario con los datos especificados en el archivo seeds.rb."
User.create(
  email: "pecotcheandres@gmail.com",
  password: "123456",
  name: "andres2",
  last_name: "pecotche2",
  phone_number: "2262653921",
  address: "70",
  identifier_number: 4134374,
  es_admin: true
)
puts "Se ha creado un usuario con los datos especificados en el archivo seeds.rb."

Dog.create(
  name: "Firulais",
  breed: "Pitbull",
  birthdate: "2019-01-01",
  image: "",
  user_id: 1
)
puts "Se ha creado un perro con los datos especificados en el archivo seeds.rb."
Dog.create(
  name: "Ringo",
  breed: "caniche",
  birthdate: "2018-01-01",
  image: "/home/andres/Downloads/perrito.jpg",
  user_id: 1
)
puts "Se ha creado un perro con los datos especificados en el archivo seeds.rb."