class StartupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite, :dislikes]

  def index
    @startups = case params[:order]
            when 'by_favorite_count'
              Startup.publish.by_favorite_count
            else
              Startup.publish.recent
            end
    @startups = @startups.paginate(page: params[:page], per_page: 10)
  end

  def show
    @startup = startup.find(params[:id])
    @startup.view_count += 1;
    @startup.save
  end

  def favorite
    @startup = startup.find(params[:id])
    unless current_user.is_follower_of_startup?(@startup)
      current_user.favorite_startup!(@startup)
      update_favorite_count
      redirect_to :back, notice: "收藏创业公司#{@startup.title}成功！"
    else
      flash[:warning] = "您已经收藏过这个创业公司！"
    end
  end

  def dislikes
    @startup = startup.find(params[:id])
    if current_user.is_follower_of_startup?(@startup)
      current_user.dislikes_startup!(@startup)
      update_favorite_count
      redirect_to :back, alert: "已取消收藏创业公司#{@startup.title}！"
    else
      flash[:warning] = "您没有收藏本创业公司！"
    end
  end

  private

  def update_favorite_count
    @startup.favorite_count = @startup.followers.count
    @startup.save
  end
end
