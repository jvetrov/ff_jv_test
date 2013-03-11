class SessionController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :settings]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
    #Login Form
  end

  def login_attempt
    authorized_user = User.authenticate(params[:login_username], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:role_id] = authorized_user.role_id
      flash[:notice] = "You logged in as #{authorized_user.username}"
      flash[:class] = "alert alert-success"
      redirect_to products_url
    else
      flash[:notice] = "Invalid username or password"
      flash[:class] = "alert alert-error"
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end
end
