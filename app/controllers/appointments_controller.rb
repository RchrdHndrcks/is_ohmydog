# app/controllers/appointment_controller.rb

class AppointmentsController < ApplicationController

  before_action :authenticate_user! 

  def new

      @appointment = Appointment.new

  end

  def create
    @user_id = current_user.id 
    @dog_id = params[:appointment][:dog_id]
    @appointment = current_user.appointments.build(appointment_params)
    if Appointment.where(user_id: @user_id, state: "en_espera", dog_id: @dog_id).exists?
      flash[:alert] = "Ya tienes un turno pendiente"
      redirect_to new_appointment_path
    else
      if @appointment.save
        Rails.logger.debug("Turno creado exitosamente") # Agregar registro de depuración
        redirect_to confirmation_appointment_path(@appointment)
      else
        Rails.logger.debug("Error en la creación del turno") # Agregar registro de depuración
      render :new
      end
    end

  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def show
    @appointment = Appointment.find(params[:id])

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
    @user_id = current_user.id # cuando tengamos usuario logeado poner current_user.id
    @appointments = Appointment.where(user_id: @user_id)
    if @appointments
    # Si se encuentra el turno, mostrar los detalles
    else
    # Si no se encuentra el turno, establecer un mensaje
    @no_appointments_message = "No tienes turnos en este momento."
    end
  end

  def update_state
    @appointment = Appointment.find(params[:id])
    if @appointment.update(state: params[:appointment][:state])
      # Maneja la actualización exitosa
    else
      # Maneja la actualización fallida
    end
  end

  def update_date
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_date: params[:appointment][:appointment_date], state: 'aceptado')
      flash[:notice] = "Se ha cargado la fecha"
      render 'index'
    else
      # Maneja la actualización fallida
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:timeSlot, :user_id, :appointment_date, :dog_id)
  end

  def confirmation

    #@appointment = Appointment.find(params[:id])
  end
end