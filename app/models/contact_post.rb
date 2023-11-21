class ContactPost < ApplicationRecord
    validates :role, inclusion: { in: %w(Paseador Cuidador) }
    validates :name, :phone_number, :role, presence: true
    validates :email, presence: true

    #validate :validate_email_repetition

    #private

    #def validate_email_repetition
        # Verifica que el email no se repita más de dos veces en los registros existentes
      #  if ContactPost.where(email: email).count >= 2
       #     errors.add(:email, "El email ya está siendo utilizado más de 2 veces")
       # end
    #end
end
