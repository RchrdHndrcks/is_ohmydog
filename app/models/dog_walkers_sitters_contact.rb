class DogWalkersSittersContact < ApplicationRecord
    validates :nombre, :email, :telefono, :mensaje, presence: true
    attr_accessor :contact_post_email, :contact_post_id
end
