module SessionsHelper
  def current_user
    session[:user]
  end
end
