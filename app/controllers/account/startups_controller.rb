class Account::StartupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @jobs = current_user.favorited_startups
  end
end
