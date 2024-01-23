class SessionsController < ApplicationController
  
  # Akcja dla wyświetlenia formularza logowania
  def new
  end

  # Akcja obsługująca proces logowania
  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])
    if user
      login(user)
      redirect_to events_path, notice: "Zalogowano pomyślnie"
    else
      flash[:alert] = "Nieprawidłowy email, bądź hasło"
      render :new, status: :unprocessable_entity
  end
end

   # Akcja obsługująca proces wylogowywania
  def destroy
    logout current_user
    redirect_to root_path, notice: "Zostałeś wylogowany"
  end
end