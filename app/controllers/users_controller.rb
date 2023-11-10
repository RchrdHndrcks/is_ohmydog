class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user, only: [:search]
  def search
    if params[:query].present?
      @users = User.where("name LIKE :query OR email LIKE :query", query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end

  private

  def admin_user
    unless current_user && current_user.es_admin?
      flash[:alert] = 'Acceso no autorizado'
      redirect_to root_path
    end
  end

end