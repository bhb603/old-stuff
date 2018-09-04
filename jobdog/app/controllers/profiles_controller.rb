class ProfilesController < ApplicationController
  before_filter :require_login
  
  def show
    begin
      @user = User.includes(:profile).includes(:ratings).find(params[:user_id])
    rescue
      flash[:errors] = ["User does not exist!"]
      redirect_to home_url
    else
      render :show
    end
  end
end
