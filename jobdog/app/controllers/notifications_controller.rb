class NotificationsController < ApplicationController
  before_filter :require_login
  
  def mark_as_read
    notification = @current_user.notifications.find(params[:id])
    
    if notification.read 
      redirect_to home_url
    else
      flash[:errors] = ["Something went wrong"]
      redirect_to home_url
    end
    
  end
end