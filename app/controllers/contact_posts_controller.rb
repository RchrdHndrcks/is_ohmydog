class ContactPostsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin, only: [:new, :create]

    def index
        @contact_posts = ContactPost.all
    end

    def show
        @contact_post = ContactPost.find(params[:id])
    end

    def new
        @contact_post = ContactPost.new
    end

    def create
        @contact_post = ContactPost.new(contact_post_params)

        if @contact_post.save
            redirect_to paseadores_cuidadores_path, notice: 'Contacto creado exitosamente.'
        else
            flash.now[:alert] = 'Error al crear el contacto.'
            render :new
        end
    end

    def paseadores_cuidadores
        @contact_posts = current_user.es_admin? ? ContactPost.all : ContactPost.where(user_id: current_user.id)
      end

    private

    def contact_post_params
        params.require(:contact_post).permit(:name, :email, :phone_number, :role)
    end

    def check_admin
        redirect_to root_path, alert: 'No tienes permiso para realizar esta acción.' unless current_user&.es_admin?
    end
end
