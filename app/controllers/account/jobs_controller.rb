class Account::JobsController < ApplicationController
  before_action :authenticate_user!

  def index
    @jobs = current_user.favorited_jobs
  end
end
