class RatingsController < ApplicationController
  before_filter :require_login
  
  def edit
    @job = Job.includes(:rating).includes(:awardee).includes(:awardee_profile).find(params[:id])
    @rating = @job.rating
    render :edit
  end
  
  def update
    job = @current_user.jobs.includes(:rating).find(params[:id])
    @rating = job.rating
    @rating.assign_attributes(params[:rating])
    @rating.completed = true 
    if @rating.save
      job.close
      flash[:notices] = ["Rating complete!"]
      redirect_to job_url(params[:id])
    else
      flash.now[:errors] = @rating.errors.full_messages
      render :edit
    end
  end

end
