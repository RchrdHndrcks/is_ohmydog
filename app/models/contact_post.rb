class ContactPost < ApplicationRecord
    validates :role, inclusion: { in: %w(Paseador Cuidador) }
    validates :name, :phone_number, :role, presence: true
    validates :email, presence: true ,uniqueness: true
end
