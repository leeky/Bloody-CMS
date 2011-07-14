class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user, :logged_in?, :admin?
  helper_method :current_user, :logged_in?, :admin?
  
  
  private 
  
  def require_login 
    unless logged_in?
      session[:redirect] = request.url unless request.xhr?
      redirect_to login_url
    end
  end
  
  def require_admin
    require_login unless logged_in?
    redirect_to root_url, :alert => "You need to be an admin to get access to this feature" unless admin?
  end
  
  def current_user
    @current_user ||= load_current_user
  end
  
  def logged_in?
    @logged_in = !@current_user.nil?
  end
  
  def admin?
    @admin = logged_in? && @current_user.is_admin
  end
  
  def load_current_user
    if session[:userid]
      begin
        return User.find(session[:userid])
      rescue
        return nil
      end
    else
      return nil
    end
  end
end
