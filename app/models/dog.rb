class Dog < ApplicationRecord
    belongs_to :user
    validates :name, presence: true, uniqueness: { scope: :user_id }
    validates :breed, presence: true
    validates :birthdate, presence: true
    has_one_attached :image
    validates :colour, presence: true
    #validates :weight, presence: true
    has_and_belongs_to_many :appointments
end
