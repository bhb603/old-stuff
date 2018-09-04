class MessagesController < ApplicationController

  def create
    @message = Message.new(params[:message])
    
    if @message.save
      flash[:notices] = ["Message sent!"]
      redirect_to about_url
    else
      flash.now[:errors] = @message.errors.full_messages
      render "sessions/about", layout: "sessions"
    end
  end
      
end
