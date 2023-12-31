class ContactPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show] 
    before_action :check_admin, only: [:new, :create, :destroy]

    def index
        @page_title = "Paseadores y Cuidadores"
        @contact_posts = ContactPost.all
    end

    def show
        @contact_post = ContactPost.find(params[:id])
    end

    def new
        @page_title = "Crear contacto"
        @contact_post = ContactPost.new
    end

    def create
        @contact_post = ContactPost.new(contact_post_params)

        if @contact_post.save
            redirect_to paseadores_cuidadores_path, notice: 'Contacto creado exitosamente.'
        else
            flash.now[:alert] = 'Por favor, complete todos los campos.'
            render :new
        end
    end

    def edit
        @contact_post = ContactPost.find(params[:id])
    end

    def destroy
        @contact_post = ContactPost.find(params[:id])
        @contact_post.destroy
        redirect_to paseadores_cuidadores_path, notice: 'Contacto eliminado exitosamente.'
    end
  

    def update
        @contact_post = ContactPost.find(params[:id])
    
        if @contact_post.update(contact_post_params)
          redirect_to paseadores_cuidadores_path, notice: 'Contacto actualizado exitosamente.'
        else
          flash.now[:alert] = 'Error al actualizar el contacto.'
          render :edit
        end
      end

    def paseadores_cuidadores
        @contact_posts = current_user.es_admin? ? ContactPost.all : ContactPost.where(user_id: current_user.id)
      end

    private

    def contact_post_params
        params.require(:contact_post).permit(:name, :email, :phone_number, :role, :photo, :zone, :availability)
    end

    def contact
        # Lógica adicional si es necesario
        redirect_to new_dog_walkers_sitters_contact_path(contact_post_id: params[:contact_post_id])
      end

    def check_admin
        redirect_to root_path, alert: 'No tienes permiso para realizar esta acción.' unless current_user&.es_admin?
    end
end
