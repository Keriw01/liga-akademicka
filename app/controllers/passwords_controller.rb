class PasswordsController < ApplicationController

  # Wymaga autentykacji użytkownika przed wykonaniem akcji w kontrolerze
  before_action :authenticate_user!

  # Akcja do wyświetlania formularza edycji hasła
  def edit
  end

   # Akcja do aktualizacji hasła użytkownika
  def update
    if current_user.update(password_params)
      redirect_to edit_password_path, notice: "Twoje hasło zostało pomyślnie zaktulizowane"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  # Parametry dozwolone dla aktualizacji hasła, z domyślną wartością dla :password_challenge
  def password_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      :password_challenge
    ).with_defaults(password_challenge: "")
  end
end
