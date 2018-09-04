class SessionsController < ApplicationController  
  def front
    render :front
  end
  
  def new
    render :new
  end
  
  def create
    begin
      @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    rescue
      flash.now[:errors] = ["Invalid credentials!"]
      render :new
    else
      login(@user)
      redirect_to home_url
    end
  end 
  
  def destroy
    logout(current_user)
    @user = User.new
    redirect_to root_url
  end
  
  def oauth_login 
    auth = request.env['omniauth.auth']
    user = User.where("provider= ? AND uid = ?", auth["provider"], auth["uid"]).first_or_initialize(
      email: auth["info"]["email"], uid: auth["uid"], 
      provider: auth["provider"],
      password: SecureRandom.urlsafe_base64
      )
    unless user.id?
      user.build_profile(first_name: auth["info"]["first_name"], 
        last_name: auth["info"]["last_name"], 
        google_photo: auth["info"]["image"],
        input_location: "New York, NY" # default...user need to edit profile
        )
    end
  
    if user.save
      login(user)
      redirect_to home_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end 
  
  def oauth_failure
    redirect_to new_user_url
  end
  
  def about
    @message = Message.new
    render :about
  end
end
