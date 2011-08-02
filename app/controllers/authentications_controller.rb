class AuthenticationsController < ApplicationController
  skip_before_filter :ensure_one_admin, :only => [:setup, :create]
  
  
  def new
    @authentications = current_user.authentications if current_user
  end

  def setup
    request.env['omniauth.strategy'].consumer_key = Settings.get('twitter:consumer_key')
    request.env['omniauth.strategy'].consumer_secret = Settings.get('twitter:consumer_secret')
    
    render :text => "Setup complete.", :status => 404
  end

  def create
    auth = request.env["omniauth.auth"]
    current_user = User.find_or_create_by_omniauth(auth)
    cookies.permanent[:auth_token] = current_user.auth_token unless current_user.nil?
    
    target = root_url
    unless session[:redirect].nil?
      target = session[:redirect]
      session.delete :redirect
    end
    redirect_to target, :notice => "Welcome!"
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "Bye, bye!"
  end
end