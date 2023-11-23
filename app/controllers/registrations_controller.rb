class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  before_action :check_admin, only: [:new, :create]
  skip_before_action :require_no_authentication, only: [:new, :create]
  Rails.logger.debug("paso before:action-------------------------------------------------------------------------------")

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_upbut#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:user][:id])
    
    # Si el checkbox no está marcado, elimina los campos relacionados con la contraseña
    if params[:user][:change_password_checkbox] == "1"
      update_password
    else
      params[:user].delete(:current_password)
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to root_path
      set_flash_message! :notice, :updated
    else
      render :edit
    end
  end
  
  private

  def update_password
    # Agrega lógica para manejar la actualización de la contraseña aquí
    # Puedes usar métodos de Devise para cambiar la contraseña sin cerrar la sesión
    if @user.update_with_password(password_params)
      bypass_sign_in(@user) # Evita cerrar la sesión después de cambiar la contraseña
    end
  end

  def user_params
    params.require(:user).permit(:id, :name, :last_name, :identifier_number, :address, :phone_number, :email, :password, :password_confirmation, :es_admin)
  end
  
  def check_admin
    Rails.logger.debug("entro----check-admin--------------------------------------------------------------------------------")
    unless current_user && current_user.es_admin?
      Rails.logger.debug("entro------a no logeado o no admin-------------------------------------------------------------------------------")
      
      redirect_to root_path
      flash[:alert] = "Acceso no autorizado."
    end
  end

  def sign_up_params 
    params.require(:user).permit(:name, :last_name, :identifier_number, :address, :phone_number, :email, :password, :password_confirmation, :es_admin)
  end

  #def account_update_params
  #  params.require(:user).permit(:name, :last_name, :address, :phone_number, :identifier_number, :email, :password)
  #end

end