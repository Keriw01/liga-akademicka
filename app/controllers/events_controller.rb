class EventsController < ApplicationController
    # Filtr sprawdzający, czy użytkownik jest zalogowany
    before_action :authenticate_user!

    # Filtr sprawdzający, czy użytkownik ma uprawnienia administratora
    before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
    
    # Filtr ustawiający zmienną @event dla określonych akcji
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    # Akcja wyświetlająca listę wydarzeń
    def index
      @events = Event.order(date: :desc)
      @user = current_user
    end
    
    # Akcja wyświetlająca pojedyncze wydarzenie
    def show
    end

    # Akcja tworząca nowe wydarzenie
    def new
      @event = Event.new
    end
    
    # Akcja zapisująca nowe wydarzenie do bazy danych
    def create
      @event = Event.new(event_params)
  
      if @event.save
        redirect_to @event, notice: "Wydarzenie zostało pomyślnie utworzone."
      else
        render :new
      end
    end
    
    # Akcja wyświetlająca formularz edycji wydarzenia
    def edit
    end
  
    # Akcja zapisująca zmiany w edytowanym wydarzeniu
    def update
      if @event.update(event_params)
        redirect_to @event, notice: "Wydarzenie zostało pomyślnie zaktualizowane."
      else
        render :edit
      end
    end

    # Akcja usuwająca wydarzenie
    def destroy
        @event = Event.find(params[:id])
        @event.delete
        redirect_to events_path, notice: "Wydarzenie zostało pomyślnie usunięte."
    end
  
    private
    
    # Ustawienie zmiennej @event na podstawie przekazanego identyfikatora
    def set_event
      @event = Event.find(params[:id])
    end
    
    # Parametry akcji create i update
    def event_params
      params.require(:event).permit(:name_first_team, :name_second_team, :date, :team_first_score, :team_second_score)
    end
    
    # Sprawdzenie uprawnień administratora
    def require_admin
      redirect_to root_path, alert: "Brak uprawnień" unless current_user.role == "admin"
    end
  end
  