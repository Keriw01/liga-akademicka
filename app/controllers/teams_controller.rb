class TeamsController < ApplicationController

  # Sprawdza, czy użytkownik jest zalogowany
  before_action :authenticate_user!

  # Sprawdza, czy użytkownik posiada uprawnienia administratora
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  # Sprawdza, czy zalogowany użytkownik ma rolę administratora.
  def require_admin
    redirect_to profile_path, alert: "Brak uprawnień" unless current_user.role=="admin"
  end

  # Obsługuje dołączanie użytkownika do drużyny
  def join
    team = Team.find(params[:user][:team_id])
    current_user.team = team

    if current_user.save
      redirect_to profile_path, notice: "Zapisano do drużyny #{team.name}"
    else
      redirect_to profile_path, alert: "Błąd podczas zapisywania do drużyny"
    end
  end

  # Renderuje formularz do tworzenia nowej drużyny
  def new
    @team = Team.new
  end

  # Obsługuje tworzenie nowej drużyny na podstawie danych z formularza
  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to profile_path, notice: "Utworzono drużynę"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Renderuje formularz edycji drużyny
  def edit
    @team = Team.find(params[:id])
    @users = User.all
  end

  # Aktualizuje informacje o drużynie na podstawie danych z formularza
  def update
    @team = Team.find(params[:id])

    if @team.update(team_params)
      redirect_to profile_path, notice: "Zaktualizowano drużynę"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Usuwa drużynę
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to profile_path, notice: "Usunięto drużynę"
  end

  # Pobiera listę wszystkich drużyn i je wyświetla
  def index
    @teams = Team.all
  end

  # Dodaje użytkownika do drużyny
  def add_user
    @team = Team.find(params[:id])
    @user = User.find(params[:user_id])
    @team.users << @user

    redirect_to edit_team_path(@team), notice: "Użytkownik został dodany do drużyny."
  end

  # Usuwa użytkownika z drużyny
  def remove_user
    @team = Team.find(params[:id])
    @user = User.find(params[:user_id])
    @team.users.delete(@user)

    redirect_to edit_team_path(@team), notice: "Użytkownik został usunięty z drużyny."
  end

  private
  # Określa dozwolone parametry dla formularza drużyny
  def team_params
    params.require(:team).permit(:name, :description)
  end
end
