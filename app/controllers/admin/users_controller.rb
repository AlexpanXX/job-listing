class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  before_action :find_user_by_id, only: [:show, :edit, :update, :destroy, :hide, :publish]
  layout "admin"

  def index
    @users = User.all.recent.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def find_user_by_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :is_admin)
  end
end
