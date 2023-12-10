class DogWalkersSittersContact < ApplicationRecord
    validates :nombre, :email, :telefono, :mensaje, presence: true
    attr_accessor :post_creator_email, :contact_post_id
end
