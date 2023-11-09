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

  def update
    # Find the user by ID
    @user = User.find(current_user.id)

    # Check if the user is updating the password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user][:password] = @user.password
      params[:user][:password_confirmation] = @user.password
    end

    # Use the regular update method provided by Devise
    if @user.update(account_update_params)
      bypass_sign_in(@user)
      set_flash_message! :notice, :updated
      redirect_to after_update_path_for(@user)
    else
      clean_up_passwords @user
      render :edit
    end
  end


  
  private

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

  def account_update_params
    params.require(:user).permit(:name, :last_name, :address, :phone_number, :identifier_number, :email, :password)
  end

end