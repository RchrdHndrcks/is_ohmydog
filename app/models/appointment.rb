# app/models/appointment.rb
class Appointment < ApplicationRecord
    enum state: { en_espera: 0, aceptado: 1, rechazado: 2, cancelado: 3 }
    enum timeSlot: { mañana: 0, tarde: 1 }
    attribute :appointment_date, :datetime
    enum reason: { urgencia: 0, consulta_general: 1, castración: 2, vacunación: 3 }
    String :rejection_reason
    has_and_belongs_to_many :dogs
end