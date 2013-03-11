class ApplicationController < ActionController::Base
  protect_from_forgery
  protected

  def authenticate_user
    unless session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    else
      # set current_user by the current user object
      @current_user = User.find session[:user_id]
      return true
    end
  end

  def check_user_permission
    unless session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    else
      if session[:role_id] == 1 #if admin
        return true
      else
        redirect_to(:controller => 'products', :action => 'index')
        return false
      end
    end
  end

  #save_login_state, prevents the user from accessing the signup and login pages whilst logged in.
  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
end
