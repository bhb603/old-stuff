class AwardsController < ApplicationController
  before_filter :require_login

  def index
    @awards = @current_user.awards.includes(:job).order("updated_at DESC") 
    render :index
  end
  
  def create
    @job = Job.find(params[:job_id])
    
    if @job.user_id == @current_user.id
      if @job.grant_award(params[:bidder_id])
        flash[:notices] = ["Award granted!"]
        redirect_to job_url(@job)
      else
        flash[:errors] = @job.errors.full_messages
        redirect_to job_url(@job)
      end
    else
      flash[:errors] = ["Unauthorized to grant award"]
      redirect_to job_url(params[:job_id])
    end
  end
  
  def destroy
    @job = Job.find(params[:job_id])
    
    if @job.user_id == @current_user.id
      if @job.revoke_award
        flash[:notices] = ["Award revoked!"]
        redirect_to job_url(@job)
      else
        flash[:errors] = @job.errors.full_messages
        redirect_to job_url(@job)
      end
    else
      flash[:errors] = ["Unauthorized to revoke award"]
      redirect_to job_url(params[:job_id])
    end
  end

end
