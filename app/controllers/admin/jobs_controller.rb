class Admin::JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  before_action :find_job_by_id, only: [:show, :edit, :update, :destroy, :hide, :publish]

  def index
    @jobs = Job.all.recent.paginate(page: params[:page], per_page: 10)
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def update
    if @job.update(job_params)
      redirect_to admin_jobs_path
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to admin_jobs_path
  end

  def hide
    unless @job.is_hidden && @job.hide!
      redirect_to admin_jobs_path, notice: "Job has been hidden."
    else
      flash[:warning] = "Job already hidden."
    end
  end

  def publish
    if @job.is_hidden && @job.publish!
      redirect_to admin_jobs_path, notice: "Job has been published."
    else
      flash[:warning] = "Job already published."
    end
  end

  private

  def find_job_by_id
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden)
  end
end
