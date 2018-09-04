class BidsController < ApplicationController
  before_filter :require_login
  
  def index
    @bids = @current_user.bids.includes(:job).order("updated_at DESC")
    render :index
  end
  
  def create
    @job = Job.find(params[:job_id])
    
    if @current_user.id != @job.user_id
      begin
        @job.add_bid(@current_user.id)
        flash[:notices] = ["Congrats you placed a bid!"]
        redirect_to job_url(params[:job_id])
      rescue StatusError
        flash[:errors] = ["Can't bid on a job that's not open"]
        redirect_to job_url(params[:job_id])
      rescue
        flash[:errors] = ["Users can only bid once"]
        redirect_to job_url(params[:job_id])
      end
    else
      flash[:errors] = ["Can't bid on your own job"]
      redirect_to job_url(params[:job_id])
    end
  end
  
  def destroy
    @bid = Bid.includes("job").find(params[:id])
    if @bid.bidder_id == @current_user.id
      begin
        @bid.job.remove_bid(@bid.id)
        flash[:notices] = ["Bid removed!"]
        redirect_to user_bids_url(@current_user.id)
      rescue StatusError
        flash[:errors] = ["Can't remove bids unless job is open"]
        redirect_to user_bids_url(@current_user.id)
      end
    else
      flash[:errors] = ["You can't remove other users' bids"]
      redirect_to user_bids_url(@current_user.id)
    end
    
  end
  
end
