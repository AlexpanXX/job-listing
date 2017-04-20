class Admin::StartupsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  before_action :find_startup_by_id, only: [:show, :edit, :update, :destroy, :hide, :publish]
  layout "admin"

  def index
    @startups = Startup.all.recent.paginate(page: params[:page], per_page: 10)
  end

  def new
    @startup = Startup.new
  end

  def show
    @jobs = @startup.jobs.paginate(page: params[:page], per_page: 10)
  end

  def create
    @startup = Startup.new(startup_params)
    if @startup.save
      redirect_to admin_startups_path
    else
      render :new
    end
  end

  def update
    if @startup.update(startup_params)
      redirect_to admin_startups_path
    else
      render :edit
    end
  end

  def destroy
    @startup.destroy
    redirect_to admin_startups_path
  end

  def hide
    unless @startup.is_hidden
      @startup.hide!
      redirect_to admin_startups_path
    end
  end

  def publish
    if @startup.is_hidden
      @startup.publish!
      redirect_to admin_startups_path
    end
  end

  private

  def find_startup_by_id
    @startup = Startup.find(params[:id])
  end

  def startup_params
    params.require(:startup).permit(:title, :email, :description, :is_hidden)
  end
end
