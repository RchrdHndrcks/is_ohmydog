class Dog < ApplicationRecord
    belongs_to :user
    validates :name, presence: true, uniqueness: true
    validates :breed, presence: true
    validates :birthdate, presence: true
    has_one_attached :image
    #validates :weight, presence: true
end
