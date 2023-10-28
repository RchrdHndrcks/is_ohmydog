class AdoptionPost < ApplicationRecord
    validates :dog_name, presence: true
    validates :dog_age, presence: true
    validates :dog_sex, presence: true
    validates :dog_breed, presence: true
    validates :dog_charac, presence: true
    validates :dog_history, presence: true
end
