class AdminsController < ApplicationController
  
  before_filter :require_admin   

  def index
    @users = User.order("is_admin DESC")
  end
  
  def update
    @user = User.find(params[:id])
    if @user && @user.update_attributes(params[:user])
      redirect_to admins_path, :notice => "#{@user.name} is now #{"not" unless @user.is_admin} an admin"
    else
      redirect_to admins_path, :alert => "That didn't work. Please try again."
    end
  end
end