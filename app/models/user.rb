# app/models/user.rb
class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    has_secure_password
    has_many :appointments
    # Otros métodos y relaciones de modelo si los tienes
  end
  