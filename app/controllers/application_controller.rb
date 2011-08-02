class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :logged_in?, :admin?
  before_filter :current_user, :logged_in?, :admin?, :ensure_installed, :ensure_one_admin
  
  private 
  
  def require_login 
    unless logged_in?
      cookies[:auth_token] = request.url unless request.xhr?
      redirect_to login_url
    end
  end
  
  def require_admin
    require_login unless logged_in?
    redirect_to root_url, :alert => "You need to be an admin to get access to this feature" unless admin? || !logged_in?
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
  
  def ensure_installed
    redirect_to "/admin/options" unless Settings.get("installed?") 
  end
  
  def ensure_one_admin
    redirect_to "/auth/twitter" if User.admin.count.zero? && Settings.get("installed?") 
  end
  
  def load_current_user
    if cookies[:auth_token]
      begin
        return User.find_by_auth_token(cookies[:auth_token])
      rescue
        return nil
      end
    else
      return nil
    end
  end
end
