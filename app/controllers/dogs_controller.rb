class DogsController < ApplicationController
  def new
    @dog = Dog.new
  end

#  def show
#    @dog = Dog.find(params[:id])
#    @user = @dog.user
#    end


  def create
    @dog = Dog.new(dog_params)
    if @dog.save
      redirect_to @dog, notice: 'Perro registrado exitosamente'
    else
      render :new
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :breed, :birthdate, :image)
  end
end