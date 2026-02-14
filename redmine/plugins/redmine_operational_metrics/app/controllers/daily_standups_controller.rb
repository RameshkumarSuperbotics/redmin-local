class DailyStandupsController < ApplicationController
  before_action :require_login

  def index
    @users = User.active.order(:firstname)

    @daily_standups = DailyStandup.includes(:user)
                                 .order(start_at: :desc)

    if params[:user_id].present?
      @daily_standups = @daily_standups.where(user_id: params[:user_id])
    end
  end

  def new
    @daily_standup = DailyStandup.new
  end

  def create
    @daily_standup = DailyStandup.new(daily_standup_params)
    @daily_standup.user = User.current

    if @daily_standup.save
      redirect_to action: :index
    else
      render :new
    end
  end

  private

  def daily_standup_params
    params.require(:daily_standup)
          .permit(:name, :start_at, :end_at)
  end
end
