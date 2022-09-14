class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_game = UserGame.find_or_create_by(user_id: current_user.id)
    UserGame::Calculations.new(user_game: @user_game).calculate!
  end

  def upgrade_factory
    @user_game = UserGame.find_by(user_id: current_user.id)
    service = UserGame::UpgradeFactory.new(user_game: @user_game, factory_type: params[:factory_type])

    ok, err = service.upgrade
    if ok
      redirect_to root_path, notice: "Upgrade in progress"
    else
      redirect_to root_path, alert: "Couldn't upgrade factory: #{err}"
    end
  end
end
