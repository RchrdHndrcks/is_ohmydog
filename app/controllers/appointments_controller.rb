# app/controllers/appointment_controller.rb

class AppointmentsController < ApplicationController

  before_action :authenticate_user! 

  def new
    @appointment = Appointment.new
    @user_dogs = current_user.dogs
  end

  def create
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
          redirect_to new_appointment_path
          flash[:notice] = "Se ha creado el turno"
          AppointmentMailer.confirmed_appointment_email(@appointment).deliver_later
        else
          #render 'new'
          redirect_to root_path
          error = @appointment.errors.full_messages
          flash[:notice] = error
        end
      else
        redirect_to new_appointment_path
        @perro.each do |perro|
          flash[:notice] = "El perro #{@perro} ya tiene un turno en espera"
        end
      end
    else
      #redirect_to new_appointment_path
      redirect_to new_appointment_path
      flash[:notice] = "Debe seleccionar al menos un perro"
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
      flash[:notice] = "Se ha cargado la fecha"
      render 'index'
    else
      render 'edit'
    end
  end


  def index
    if current_user.es_admin?
      @appointments_en_espera = Appointment.where(state: 'en_espera')
      @appointments_aceptados = Appointment.where(state: 'aceptado')
      @appointments_rechazados = Appointment.where(state: 'rechazado')
      @appointments_cancelados = Appointment.where(state: 'cancelado')
    else
      @appointments_en_espera = Appointment.where(user_id: current_user.id, state: 'en_espera')
      @appointments_aceptados = Appointment.where(user_id: current_user.id, state: 'aceptado')
      @appointments_rechazados = Appointment.where(user_id: current_user.id, state: 'rechazado')
      @appointments_cancelados = Appointment.where(user_id: current_user.id, state: 'cancelado')

    end
  end

  def update_state
    @appointment = Appointment.find(params[:id])
    if @appointment.update(state: params[:appointment][:state], rejection_reason: params[:appointment][:rejection_reason])
      flash[:notice] = "Se ha cargado el estado"
      redirect_to appointments_path
      if params[:appointment][:state] == 'rechazado'
        AppointmentMailer.rejected_appointment_email(@appointment).deliver_later
      end
      if params[:appointment][:state] == 'cancelado'
        AppointmentMailer.canceled_appointment_email(@appointment).deliver_later
      end
    else
      flash[:notice] = "error al cargar la fecha"
      render 'index'
    end
  end

  def update_date
    @appointment = Appointment.find(params[:id])
    if params[:appointment][:appointment_date].present?
      if @appointment.appointment_date.present?
        @old_date = @appointment.appointment_date
      end
      if @appointment.update(appointment_date: params[:appointment][:appointment_date], state: 'aceptado')
        redirect_to appointments_path
        flash[:notice] = "Se ha cargado la fecha" 
        if @old_date.present?
          AppointmentMailer.modified_appointment_email(@appointment, @old_date).deliver_later
        else
          AppointmentMailer.acepted_appointment_email(@appointment).deliver_later
        end
      else
        redirect_to appointments_path
        flash[:notice] = "error al cargar la fecha"
      end
    else
      redirect_to appointments_path
      flash[:notice] = "Debe seleccionar una fecha"
    end
  end


  private

  def appointment_params
    params.require(:appointment).permit(:timeSlot, :rejection_reason, :reason, dog_ids: [])
  end

  def confirmation
  end


end