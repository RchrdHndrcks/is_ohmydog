# app/models/appointment.rb
class Appointment < ApplicationRecord
    belongs_to :user
    belongs_to :dog
    enum state: { en_espera: 0, aceptado: 1, rechazado: 2 }
    enum timeSlot: { manana: 0, tarde: 1 }
    attribute :appointment_date, :datetime
end