class New < ApplicationRecord
    belongs_to :user
    validates :title, presence: true
    validates :description, presence: true
    has_one_attached :image
end
