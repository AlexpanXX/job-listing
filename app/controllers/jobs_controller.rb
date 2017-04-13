class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.all.by_lower_bound.paginate(page: params[:page], per_page: 10)
            when 'by_upper_bound'
              Job.all.by_upper_bound.paginate(page: params[:page], per_page: 10)
            else
              Job.all.recent.paginate(page: params[:page], per_page: 10)
            end
  end
end
