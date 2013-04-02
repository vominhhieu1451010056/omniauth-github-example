class SessionsController < ApplicationController
  def new
  end

  def create_github
   raise env['omniauth.auth'].to_yaml 
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid."
      redirect_to new_session_path, notice: 'Email or password is invalid'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end