class TeamsController < ApplicationController
  before_action :authenticate_user!

  def join
    team = Team.find(params[:user][:team_id])
    current_user.team = team

    if current_user.save
      redirect_to profile_path, notice: "Zapisano do drużyny #{team.name}"
    else
      redirect_to profile_path, alert: "Błąd podczas zapisywania do drużyny"
    end
  end
end
