class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_game = UserGame.find_or_create_by(user_id: current_user.id)
  end
end
