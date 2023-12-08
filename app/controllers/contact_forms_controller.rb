class ContactFormsController < ApplicationController
  before_action :set_post, only: [:new, :create]

  def new
    @page_title = "Contactarse por adopción"
    @contact_form = ContactForm.new

    if user_signed_in?
      @contact_form.nombre = current_user.name
      @contact_form.correo = current_user.email
      @contact_form.telefono = current_user.phone_number
      # Puedes agregar más campos según sea necesario
    end

    @post_creator_email = @post.user.email if @post
  end

  def create
    @page_title = "Contactarse por adopción"
    @contact_form = ContactForm.new(contact_form_params)
    @contact_form.mensaje = "¡Alguien se interesó en tu anuncio de adopción! La persona interesada es " + @contact_form.nombre + ", su telefono es " + @contact_form.telefono + " y su mail es " + @contact_form.correo + ". ¡Contactalo pronto para seguir con el proceso de adopción!" 

    if @contact_form.save
      # Envía el correo al creador del post de adopción
      post_creator_email = @post.user.email if @post
      PostAdoptionMailer.contact_email(@contact_form, post_creator_email).deliver_now
      redirect_to root_path, notice: "¡Correo electrónico enviado con éxito!"
    else
      render 'new'
    end
  end

  private 

  def set_post
    @post = AdoptionPost.find(params[:adoption_post_id]) if params[:adoption_post_id]
  end

  def contact_form_params
    params.require(:contact_form).permit(:nombre, :correo, :telefono, :mensaje, :post_creator_email, :adoption_post_id)
  end
end
