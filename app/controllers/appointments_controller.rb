# app/controllers/appointment_controller.rb

class AppointmentsController < ApplicationController
  def new
    @appointment = Appointment.new
  end

  def create
    user = User.find_by(id: appointment_params[:user_id])

    if user
      @appointment = user.appointments.build(appointment_params.except(:user_id))
      if @appointment.save
        Rails.logger.debug("Turno creado exitosamente") # Agregar registro de depuración
        redirect_to confirmation_appointment_path(@appointment)
      else
        Rails.logger.debug("Error en la creación del turno") # Agregar registro de depuración
        render :new
      end
    else
      Rails.logger.debug("Usuario no encontrado") # Agregar registro de depuración
      render :new
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def show
    @appointment = Appointment.find(params[:id])
    respond_to do |format|
      format.html # Esta línea indica que se utilizará la vista show.html.erb
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: 'Cita actualizada exitosamente.'
    else
      render 'edit'
    end
  end


 def index
  @user_id = 1 # cuando tengamos usuario logeado poner current_user.id
  @appointments = Appointment.where(user_id: @user_id)


  if @appointments
    # Si se encuentra el turno, mostrar los detalles

  else
    # Si no se encuentra el turno, establecer un mensaje
    @no_appointments_message = "No tienes turnos en este momento."
  end
end

  private

  def appointment_params
    params.require(:appointment).permit(:timeSlot, :user_id, :appointment_date)
  end

  def confirmation
    @appointment = Appointment.find(params[:id])
  end
end