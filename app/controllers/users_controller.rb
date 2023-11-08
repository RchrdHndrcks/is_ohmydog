class UsersController < ApplicationController
  def search
    if params[:query].present?
      @users = User.where("name LIKE :query OR email LIKE :query", query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end
end