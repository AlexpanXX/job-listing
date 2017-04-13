class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.publish.by_lower_bound.paginate(page: params[:page], per_page: 10)
            when 'by_upper_bound'
              Job.publish.by_upper_bound.paginate(page: params[:page], per_page: 10)
            else
              Job.publish.recent.paginate(page: params[:page], per_page: 10)
            end
  end

  def show
    @job = Job.find(params[:id])
  end
end
