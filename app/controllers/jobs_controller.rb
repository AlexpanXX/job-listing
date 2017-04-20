class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite, :dislikes]

  def index
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.publish.by_lower_bound
            when 'by_upper_bound'
              Job.publish.by_upper_bound
            else
              Job.publish.recent
            end
    @jobs = @jobs.paginate(page: params[:page], per_page: 10)
  end

  def show
    @job = Job.find(params[:id])
  end

  def favorite
    @job = Job.find(params[:id])
    unless current_user.is_follower_of_job?(@job)
      current_user.favorite_job!(@job)
      redirect_to :back, notice: "收藏职位#{@job.title}成功！"
    else
      flash[:warning] = "您已经收藏过这个职位！"
    end
  end

  def dislikes
    @job = Job.find(params[:id])
    if current_user.is_follower_of_job?(@job)
      current_user.dislikes_job!(@job)
      redirect_to :back, alert: "已取消收藏职位#{@job.title}！"
    else
      flash[:warning] = "您没有收藏本职位！"
    end
  end
end
