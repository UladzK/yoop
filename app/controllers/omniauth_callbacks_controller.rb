class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    user = User.find_for_facebook_oauth(auth_hash)    
    if user.persisted?
      sign_in user
      redirect_to root_url, :notice => "Signed in!"
    else
      flash.now[:alert] = "Authentification failed"
      render :action => 'new'
    end
  end

  def google_oauth2    
    user = User.find_for_google_oauth2(auth_hash)
    if user.persisted?
      sign_in user
      redirect_to root_url, :notice => "Signed in!"
    else
      flash.now[:alert] = "Authentification failed"
      render :action => 'new'
    end
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
