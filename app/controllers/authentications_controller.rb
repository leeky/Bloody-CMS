class AuthenticationsController < ApplicationController
  def new
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["omniauth.auth"]
    current_user = User.find_or_create_by_omniauth(auth)
    session[:userid] = current_user.id unless current_user.nil?
    
    target = root_url
    unless session[:redirect].nil?
      target = session[:redirect]
      session.delete :redirect
    end
    redirect_to target, :notice => "Welcome!"
  end

  def destroy
    session.delete :userid
    redirect_to root_url, :notice => "Bye, bye!"
  end
end