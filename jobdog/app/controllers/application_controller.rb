class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  def current_user
    return nil unless session[:session_token]
    User.includes(:profile).find_by_session_token(session[:session_token])
  end
    
  private
  
  def require_login
    @current_user = current_user
    if !@current_user
      flash[:errors] = ["You must be logged to access this section"]
      redirect_to new_session_url
    end
  end
  
  def login(user)
    session[:session_token] = SecureRandom.urlsafe_base64
    user.session_token = session[:session_token]
    user.save!
  end
  
  def logout(user)
    user.session_token = SecureRandom.urlsafe_base64
    session[:session_token] = nil
  end
end
