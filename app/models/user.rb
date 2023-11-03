# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    validates :name, presence: false
    validates :email, presence: true, uniqueness: true
    has_many :appointments
    has_many :dogs
    # Otros métodos y relaciones de modelo si los tienes
  end
  