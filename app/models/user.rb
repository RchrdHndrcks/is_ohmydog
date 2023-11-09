# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    validates :name, presence: false
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, allow_blank: true, length: { minimum: 6 }
    validates :identifier_number, presence: true, uniqueness: true
    validates :last_name, presence: true
    validates :address, presence: true
    validates :phone_number, presence: true
    validates :es_admin, presence: false
    has_many :dogs
    # Otros métodos y relaciones de modelo si los tienes

  end
  