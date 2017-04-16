class Admin::ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout "admin"

  def index
    @job = Job.find(params[:job_id])
    @resuems = @job.resumes
  end

  def edit
    @job = Job.find(params[:job_id])
    @resume = Resume.find(params[:id])
  end

  def update
    @resume = Resume.find(params[:id])
    if @resume.update(resume_params)
      redirect_to admin_job_path(@resume.job), notice: "Resume successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to admin_job_path(@resume.job), alert: "Resume deleted."
  end

  private

  def resume_params
    params.require(:resume).permit(:content, :attachment)
  end
end
