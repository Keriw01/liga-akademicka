class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def require_admin
    redirect_to profile_path, alert: "Brak uprawnień" unless current_user.role=="admin"
  end

  def join
    team = Team.find(params[:user][:team_id])
    current_user.team = team

    if current_user.save
      redirect_to profile_path, notice: "Zapisano do drużyny #{team.name}"
    else
      redirect_to profile_path, alert: "Błąd podczas zapisywania do drużyny"
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to profile_path, notice: "Utworzono drużynę"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @team = Team.find_by(params[:team_id])
  end

  def update
    @team = Team.find(params[:id])

    if @team.update(team_params)
      redirect_to profile_path, notice: "Zaktualizowano drużynę"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to profile_path, notice: "Usunięto drużynę"
  end

  def index
    @teams = Team.all
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end
end
