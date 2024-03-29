class TeamMembersController < ApplicationController

  # Akcja usuwająca użytkownika z drużyny
  def remove_user
    @team = Team.find(params[:id])
    @user = User.find(params[:user_id])
    @team.users.delete(@user)

    redirect_to edit_team_path(@team), notice: "Użytkownik został usunięty z drużyny."
  end

  # Akcja dodająca użytkownika do drużyny
  def add_user
    @team = Team.find(params[:id])
    @user = User.find(params[:user_id])
    @team.users << @user

    redirect_to edit_team_path(@team), notice: "Użytkownik został dodany do drużyny."
  end
end
