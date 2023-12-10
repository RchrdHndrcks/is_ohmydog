class ContactFormsController < ApplicationController
  before_action :set_post, only: [:new]

  def new
    @page_title = "Contactarse por adopción"
    @contact_form = ContactForm.new

    if user_signed_in?
      @contact_form.nombre = current_user.name
      @contact_form.correo = current_user.email
      @contact_form.telefono = current_user.phone_number
      # Puedes agregar más campos según sea necesario
    end

    @post_creator_email = User.find(@post.user_id).email
    @adoption_post_id = @post.id
    #@adoption_post = @post
  end

  def create
    @page_title = "Contactarse por adopción"
    @contact_form = ContactForm.new(contact_form_params)
    @adoption_post = AdoptionPost.find(@contact_form.adoption_post_id)
    @contact_form.mensaje = "¡Me interesa tu anuncio de adopción para " + @adoption_post.dog_name + "! Mi nombre es " + @contact_form.nombre + ", mi telefono es " + @contact_form.telefono + " y mi mail es " + @contact_form.correo + ". ¡Contactame pronto para seguir con el proceso de adopción!" 

    admin_emails = User.where(es_admin: true).pluck(:email)
    Rails.logger.debug("admin emails")
    Rails.logger.debug(admin_emails)

    if @contact_form.save
      # Envía el correo al creador del post de adopción
      post_creator_email = @contact_form.post_creator_email
      PostAdoptionMailer.contact_email(@contact_form, post_creator_email, admin_emails).deliver_later
      redirect_to root_path, notice: "¡Correo electrónico enviado con éxito!"
    else
      render 'new'
    end
  end

  private 

  def set_post
    @post = AdoptionPost.find(params[:adoption_post_id]) 
  end

  def contact_form_params
    params.require(:contact_form).permit(:nombre, :correo, :telefono, :mensaje, :post_creator_email, :adoption_post_id)
  end
end
