class EventsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_event, only: [:show, :edit, :update, :destroy]
  
    def index
      @events = Event.order(date: :desc)
      @user = current_user
    end
  
    def show
    end

    def new
      @event = Event.new
    end
  
    def create
      @event = Event.new(event_params)
  
      if @event.save
        redirect_to @event, notice: 'Wydarzenie zostało pomyślnie utworzone.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @event.update(event_params)
        redirect_to @event, notice: 'Wydarzenie zostało pomyślnie zaktualizowane.'
      else
        render :edit
      end
    end

    def destroy
        @event = Event.find(params[:id])
        @event.delete
        redirect_to events_path, notice: 'Wydarzenie zostało pomyślnie usunięte.'
    end
  
    private
  
    def set_event
      @event = Event.find(params[:id])
    end
  
    def event_params
      params.require(:event).permit(:name_first_team, :name_second_team, :date, :team_first_score, :team_second_score)
    end
  
    def require_admin
      redirect_to root_path, alert: 'Brak uprawnień' unless current_user.role == 'admin'
    end
  end
  