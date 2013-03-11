class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_filter :authenticate_user, :only => [:update, :edit, :manage_users]
  before_filter :check_user_permission, :only => [:destroy, :index]

  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    #check that user has permission
    if session[:role_id] == 1 || params[:id].gsub(/\D/, '').to_i == session[:user_id]
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to(:controller => 'products', :action => 'index')
    end
  end

  def new
    @user = User.new
  end


  def edit
    if params[:id]
      @user = User.find(params[:id])
    end
    else if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html {
          flash[:notice] = 'User was successfully created.'
          redirect_to products_url
        }
        format.json { head :no_content }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    #it password is blank leave it unsaved
    unless params[:user][:password].blank?
      @user.change_password
    else
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html {
          flash[:notice] = 'User was successfully updated.'
          render action: "edit"
        }
        format.json { render json: @user }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
