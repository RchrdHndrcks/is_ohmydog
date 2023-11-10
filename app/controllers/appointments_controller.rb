# app/controllers/appointment_controller.rb

class AppointmentsController < ApplicationController

  before_action :authenticate_user! 

  def new
    Rails.logger.debug("entro------a new-------------------------------------------------------------------------------")
    @appointment = Appointment.new
    @user_dogs = current_user.dogs
  end

  def create
    Rails.logger.debug("entro------a create-------------------------------------------------------------------------------")
    @appointment = Appointment.new(appointment_params)
    @appointment.user_id = current_user.id
    if !@appointment.dog_ids.empty?
      @perro = []
      @appointment.dog_ids.each do |dog_id|
        if @ultimo_turno_del_perro_en_join = AppointmentsDog.where(dog_id: dog_id).order(created_at: :desc).first
          @id_del_ultimo_turno_del_perro = @ultimo_turno_del_perro_en_join.appointment_id
          if Appointment.find(@id_del_ultimo_turno_del_perro).state == 'en_espera'
            @perro << Dog.find(dog_id).name
          end
        end
      end
      if !@perro.any?
        if @appointment.save
          Rails.logger.debug("entro------a save--create-----------------------------------------------------------------------------")
          redirect_to new_appointment_path
          flash[:notice] = "Se ha creado el turno"
        else
          #render 'new'
          redirect_to root_path
          error = @appointment.errors.full_messages
          flash[:notice] = error
          Rails.logger.debug("entro------a error--create-----------------------------------------------------------------------------")
        end
      else
        redirect_to new_appointment_path
        @perro.each do |perro|
          flash[:notice] = "El perro #{@perro} ya tiene un turno en espera"
        end
      end
    else
      Rails.logger.debug("entro------a else--es de perros empty-----------------------------------------------------------------------------")
      #redirect_to new_appointment_path
      redirect_to new_appointment_path
      flash[:notice] = "Debe seleccionar al menos un perro"
    end
  end

  def edit
    Rails.logger.debug("entro------a edit-------------------------------------------------------------------------------")
    @appointment = Appointment.find(params[:id])
  end

  def show
    Rails.logger.debug("entro------a show-------------------------------------------------------------------------------")
    @appointment = Appointment.find(params[:id])
    
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      Rails.logger.debug("entro------a update-------------------------------------------------------------------------------")
      flash[:notice] = "Se ha cargado la fecha"
      render 'index'
    else
      Rails.logger.debug("entro------a update error-------------------------------------------------------------------------------")
      render 'edit'
    end
  end


  def index
    if current_user.es_admin?
      @appointments_en_espera = Appointment.where(state: 'en_espera')
      @appointments_aceptados = Appointment.where(state: 'aceptado')
      @appointments_rechazados = Appointment.where(state: 'rechazado')
    else
      @appointments_en_espera = Appointment.where(user_id: current_user.id, state: 'en_espera')
      @appointments_aceptados = Appointment.where(user_id: current_user.id, state: 'aceptado')
      @appointments_rechazados = Appointment.where(user_id: current_user.id, state: 'rechazado')

    end
  end

 # def update_state
 #   @appointment = Appointment.find(params[:id])
 #   if @appointment.update(state: params[:appointment][:state])
 #     flash[:notice] = "Se ha cargado la fecha"
 #     render 'index'
 #   else
 #     flash[:notice] = "error al cargar la fecha"
 #     render 'index'
 #   end
 # end

 # def update_date
 #   @appointment = Appointment.find(params[:id])
 #   if @appointment.update(appointment_date: params[:appointment][:appointment_date], state: 'aceptado')
 #     flash[:notice] = "Se ha cargado la fecha"
 #     render 'index'
 #   else
 #     flash[:notice] = "error al cargar la fecha"
 #     render 'index'
 #   end
 # end

  private

  def appointment_params
    params.require(:appointment).permit(:timeSlot, dog_ids: [])
  end

  def confirmation
    Rails.logger.debug("entro------a confirmation------------------------------------------------------------------------------")
  end


end