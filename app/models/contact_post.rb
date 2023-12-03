class ContactPost < ApplicationRecord
    validates :role, inclusion: { in: %w(Paseador Cuidador) }
    validates :name, :phone_number, :role, :zone, :availability, presence: true
    validates :email, presence: true
    has_one_attached :photo
    #validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
    
end
