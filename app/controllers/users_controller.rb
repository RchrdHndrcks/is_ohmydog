class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: [:search]
  def search
    if params[:query].present?
      @users = User.where("identifier_number LIKE :query OR email LIKE :query", query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:user_id])
    @page_title = "Perfil de " + @user.name
    # Otras acciones que puedas necesitar para mostrar el perfil del usuario
  end


  private

  def admin_user
    unless current_user && current_user.es_admin?
      flash[:alert] = 'Acceso no autorizado'
      redirect_to root_path
    end
  end

end