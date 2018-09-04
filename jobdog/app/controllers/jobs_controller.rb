class JobsController < ApplicationController
  before_filter :require_login #sets @current_user to current_user
  
  def index

    query = params[:search] || {}
    # order = query[:order]
    
    if query[:user] == "me"
      my_jobs = @current_user.jobs #Job..where("user_id = ?", @current_user.id)
    elsif query[:user_id]
      my_jobs = Job.where("user_id = ?", query[:user_id])
    else
      my_jobs = Job.where("user_id != ?", @current_user.id)
    end
      
    if query[:status] && query[:category]
      jobs = my_jobs.includes(:user_profile).where("status IN (?)", query[:status]).where("category IN (?)", query[:category]).order("created_at DESC")
    elsif query[:status]
      jobs = my_jobs.includes(:user_profile).where("status IN (?)", query[:status]).order("created_at DESC")
    elsif query[:category]
      jobs = my_jobs.includes(:user_profile).where("category IN (?)", query[:category]).order("created_at DESC")
    else
      jobs = my_jobs.includes(:user_profile).order("created_at DESC")
    end
    
    if query[:user] == "me" || query[:distance] == "all"
      @jobs = jobs.page(params[:page]).per(5)
    else
      distance = query[:distance] || params[:distance] || 20
      close_jobs = jobs.select { |job| job.distance(@current_user.profile) < distance.to_i }
      @jobs = Kaminari.paginate_array(close_jobs).page(params[:page]).per(5)
    end
        
    if request.xhr?
      render json: @jobs 
    else 
      render :index
    end
  end

  def create
    @job = Job.new(params[:job])
    @job.user_id = @current_user.id
    if @job.save
      flash[:notices] = ["New job created!"]
      redirect_to job_url(@job)
    else
      flash.now[:errors] = @job.errors.full_messages
      render :new
    end 
  end
  
  def new
    @job = Job.new
    render :new
  end
  
  def edit
    @job = Job.find(params[:id])
    if @job.user_id == @current_user.id
      render :edit
    else
      flash[:errors] = ["Unauthorized to edit that job"]
      redirect_to home_url
    end
  end
  
  def show
    @job = Job.includes(:user).includes(:bids).includes(:bidders).includes(:rating).find(params[:id])
    render :show
  end
  
  def update
    @job = Job.find(params[:id])
    if @job.user_id == @current_user.id 
      if @job.update_attributes(params[:job])
        flash[:notices] = ["Job updated!"]
        redirect_to job_url(@job)
      else
        flash.now[:errors] = @job.errors.full_messages
        render :edit
      end
    else
      flash[:errors] = ["Unauthorized to update that job"]
      redirect_to home_url
    end
  end
  
  def destroy
    @job = Job.find(params[:id])
    if @job.user_id == @current_user.id
      @job.destroy
      flash[:notices] = ["Job deleted!"]
      redirect_to jobs_url(user_id: @current_user.id)
    else
      flash[:errors] = ["Unauthorized to delete that job"]
      redirect_to home_url
    end
  end
  
  def complete_job
    @job = Job.includes(:award).find(params[:id])
    if @job.award && @job.award.recipient_id == @current_user.id
      begin
        @job.complete
        flash[:notices] = ["Job completed!"]
        redirect_to user_awards_url(@current_user)
      rescue StatusError
        flash[:errors] = ["Only awarded jobs can be completed"]
        redirect_to user_awards_url(@current_user)
      end
    else
      flash[:errors] = ["Unauthorized to complete that job"]
      redirect_to user_awards_url(@current_user)
    end
  end
  
  def close_job
    @job = Job.find(params[:id])
    if @job.user_id == @current_user.id
      begin
        @job.close
        flash[:notices] = ["Job closed!"]
        redirect_to job_url(@job)
      rescue StatusError
        flash[:errors] = ["You can only close a job once it's completed!"]
        redirect_to job_url(@job)
      end
    else
      flash[:errors] = ["Unauthorized to close that job"]
      redirect_to home_url
    end
  end
 
end
