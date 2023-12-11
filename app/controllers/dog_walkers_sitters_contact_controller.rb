class DogWalkersSittersContactController < ApplicationController
    #before_action :set_post, only: [:new]
  
    def new
      @page_title = "Contactarse por Servicio"
      @post = ContactPost.find(params[:contact_post_id])
      @dog_walkers_sitters_contact = DogWalkersSittersContact.new
  
      if user_signed_in?
        @dog_walkers_sitters_contact.nombre = current_user.name
        @dog_walkers_sitters_contact.email = current_user.email
        @dog_walkers_sitters_contact.telefono = current_user.phone_number
        # Puedes agregar más campos según sea necesario
      end
      
      if @post.present?
        #@post_trabajador_email = User.find(@post.id).email
        @contact_post_id = @post.id
      end
    end
  
    def create
      @page_title = "Contactarse por Paseador o Cuidador"
      @contact_post = ContactPost.find(params[:dog_walkers_sitters_contact][:contact_post_id])
      @dog_walkers_sitters_contact = DogWalkersSittersContact.new(dog_walkers_sitters_contact_params)
      Rails.logger.debug(@contact_post)
      Rails.logger.debug(@dog_walkers_sitters_contact)
      @dog_walkers_sitters_contact.mensaje = "¡Me interesa solicitar tu servicio " + @contact_post.name + "! Mi nombre es " + @dog_walkers_sitters_contact.nombre + ", mi telefono es " + @dog_walkers_sitters_contact.telefono + " y mi mail es " + @dog_walkers_sitters_contact.email + ". ¡Contactame pronto para poder gozar de tus servicios laborales cuantos antes!" 
    
      admin_emails = User.where(es_admin: true).pluck(:email)
      Rails.logger.debug("admin emails")
      Rails.logger.debug(admin_emails)
  
      if @dog_walkers_sitters_contact.save
        # Envía el correo al creador del post de adopción
        #post_trabajador_email = @dog_walkers_sitters_contact.contact_post_email
        DogWalkerMailer.contact_email(@dog_walkers_sitters_contact, @contact_post.email, admin_emails).deliver_later
        redirect_to root_path, notice: "¡Correo electrónico enviado con éxito!"
      else
        render 'new'
      end
    end
  
    private 
  
    def dog_walkers_sitters_contact_params
      params.require(:dog_walkers_sitters_contact).permit(:nombre, :email, :telefono, :mensaje)
    end
  end
  