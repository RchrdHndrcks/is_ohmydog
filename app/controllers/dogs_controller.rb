class DogsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :admin_user, only: [:new, :create]

    def new
        #@user = User.find(params[:user_id]) # Obtén el usuario a partir del ID pasado como parámetro
        @dog = Dog.new # Crea un nuevo perro
      end
      
      def create
        @dog = Dog.new(dog_params) # Crea un nuevo perro con los parámetros que vienen del formulario
        Rails.logger.debug("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
        Rails.logger.debug(dog_params)
        if @dog.save
          redirect_to root_path, notice: 'Perro registrado exitosamente'
        else
          render :new
          flash[:alert] = 'No se pudo registrar el perro'
        end
      end

  def show
    @dog = Dog.find(params[:user_id])
    #@user = @dog.user
  end

  def index
    
    #user_id = params[:user_id]
    #@dogs = Dog.where(user_id: user_id)
    #se usa la siguiente opcion ya que se utiliza el @user en la vista para listar el nombre del cliente, sino la de arriba funciona tambien
    @user = User.find(params[:user_id]) # Obtén el usuario a partir del ID pasado como parámetro
    if (current_user.es_admin? || current_user.id == @user.id)
      @user = User.find(params[:user_id]) # Obtén el usuario a partir del ID pasado como parámetro
      @dogs = @user.dogs
    else
      flash[:alert] = 'Acceso no autorizado para ver esta lista de perros'
      redirect_to root_path
    end
  end
  
  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :birthdate, :image, :user_id, :colour, :observations)
  end

  def admin_user
    unless current_user && current_user.es_admin?
      flash[:alert] = 'Acceso no autorizado'
      redirect_to root_path
    end
  end

end