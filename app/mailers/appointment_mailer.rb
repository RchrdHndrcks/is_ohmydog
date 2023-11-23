
class AppointmentMailer < ApplicationMailer
    def confirmed_appointment_email(appointment)
        @user = User.find(appointment.user_id)
        @timeSlot = appointment.timeSlot
        @dogs = AppointmentsDog.where(appointment_id: appointment.id).map do |appointment_dog|
          Dog.find(appointment_dog.dog_id).name
        end
        mail(to: @user.email, subject: 'Turno solicitado exitosamente')
    end

    def rejected_appointment_email(appointment)
        @user = User.find(appointment.user_id)
        @timeSlot = appointment.timeSlot
        @dogs = AppointmentsDog.where(appointment_id: appointment.id).map do |appointment_dog|
          Dog.find(appointment_dog.dog_id).name
        end
        mail(to: @user.email, subject: 'Rechazo de Solicitud de Turno')
    end

    def acepted_appointment_email(appointment)
        @user = User.find(appointment.user_id)
        @dogs = AppointmentsDog.where(appointment_id: appointment.id).map do |appointment_dog|
          Dog.find(appointment_dog.dog_id).name
        end
        @date = appointment.appointment_date
        mail(to: @user.email, subject: 'Turno aceptado')
    end

    def canceled_appointment_email(appointment)
        @user = User.find(appointment.user_id)
        @dogs = AppointmentsDog.where(appointment_id: appointment.id).map do |appointment_dog|
          Dog.find(appointment_dog.dog_id).name
        end
        @date = appointment.appointment_date
        mail(to: @user.email, subject: 'Turno cancelado')
    end

    def modified_appointment_email(appointment, old_date)
        @old_date = old_date
        @user = User.find(appointment.user_id)
        @timeSlot = appointment.timeSlot
        @dogs = AppointmentsDog.where(appointment_id: appointment.id).map do |appointment_dog|
          Dog.find(appointment_dog.dog_id).name
        end
        @date = appointment.appointment_date
        mail(to: @user.email, subject: 'Turno modificado')
    end

end