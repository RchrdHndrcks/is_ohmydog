# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
    validates :identifier_number, presence: true, uniqueness: true
    validates :last_name, presence: true
    validates :address, presence: true
    validates :phone_number, presence: true
    validates :es_admin, presence: false
    has_many :dogs
    has_many :adoption_posts
    
    private 


    def password_required?
      new_record? || !password.nil?
    end
  end
  