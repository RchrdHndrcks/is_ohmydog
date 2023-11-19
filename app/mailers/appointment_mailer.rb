
class AppointmentMailer < ApplicationMailer
    def confirmation_appointment_email(appointment)
        @user = User.find(appointment.user_id)
        @timeSlot = appointment.timeSlot
        @dogs = AppointmentsDog.where(appointment_id: appointment.id).map do |appointment_dog|
          Dog.find(appointment_dog.dog_id).name
        end
        mail(to: @user.email, subject: 'Confirmación de Solicitud de Turno')
    end

    def rejected_appointment_email(appointment)
        @user = User.find(appointment.user_id)
        @timeSlot = appointment.timeSlot
        @dogs = AppointmentsDog.where(appointment_id: appointment.id).map do |appointment_dog|
          Dog.find(appointment_dog.dog_id).name
        end
        mail(to: @user.email, subject: 'Rechazo de Solicitud de Turno')
    end
end
