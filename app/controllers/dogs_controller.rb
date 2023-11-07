class DogsController < ApplicationController
    def new
        #@user = User.find(params[:user_id]) # Obtén el usuario a partir del ID pasado como parámetro
        @dog = Dog.new # Crea un nuevo perro
      end
      
      def create
        @dog = Dog.new(dog_params) # Crea un nuevo perro con los parámetros que vienen del formulario
        if @dog.save
          redirect_to root_path, notice: 'Perro registrado exitosamente'
        else
          render :new
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
    @dogs = @user.dogs
    
  end
  
  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :birthdate, :image, :user_id)
  end
end