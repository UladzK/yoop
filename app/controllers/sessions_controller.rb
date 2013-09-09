class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, :notice => "Signed in!"
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end
  
  def fb_create
    auth = request.env["omniauth.auth"]
    user = User.find_for_facebook_oauth(auth)    
    if user.persisted?
      session[:user_id] = user.id
      current_user = user
      redirect_to root_url, :notice => "Signed in!"
    else
      flash.now[:alert] = "Authentification failed"
      render :action => 'new'
    end
  end

  def google_create
    auth = request.env["omniauth.auth"]
    user = User.find_for_google_oauth(auth)
    if user.persisted?
      session[:user_id] = user.id
      current_user = user
      redirect_to root_url, :notice => "Signed in!"
    else
      flash.now[:alert] = "Authentification failed"
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
