class UsersController < ApplicationController
  before_filter :require_login, except: [:new, :create] #sets @current_user
  
  def new 
    @user = User.new
    @profile = Profile.new
    render :new, layout: "sessions"
  end
  
  def create
    if params[:guest]
      @user = build_guest_user
    else
      @user = User.new(params[:user])
      @user.build_profile(params[:profile])
    end
    
    if @user.save
      login(@user)
      redirect_to home_url
    else
      @profile = Profile.new(params[:profile])
      flash.now[:errors] = @user.errors.full_messages
      render :new, layout: "sessions"
    end
  end
  
  def home
    @current_user = User.includes(:profile).find(@current_user.id)
    @notifications = Notification.where("user_id = ? AND status = ?", @current_user.id, "unread").order("updated_at DESC")
    render :home
  end
  
  def edit
    @user = @current_user
    render :edit
  end
  
  def update
    @current_user.profile.update_attributes(params[:profile])
    
    if @current_user.save
      redirect_to user_profile_url(@current_user)
    else
      @user = @current_user
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end
  
  private
  
  def build_guest_user
    email = "guest#{Time.now.to_i}@example.com"
    password = SecureRandom.base64(6)
    user = User.new(email: email, password: password)
    user.build_profile(first_name: "Guest", last_name: "#{Time.now.to_i}", input_location: "New York, NY")
    user
  end
end
