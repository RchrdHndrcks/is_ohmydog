class ContactForm < ApplicationRecord
    validates :nombre, :correo, :telefono, :mensaje, presence: true
    attr_accessor :post_creator_email, :adoption_post_id
end
