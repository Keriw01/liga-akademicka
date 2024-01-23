class RegistrationsController < ApplicationController
    # Akcja dla wyświetlenia formularza rejestracyjnego
    def new
        @user = User.new
    end

    # Akcja dla przetwarzania formularza rejestracyjnego
    def create
        @user = User.new(registration_params)
        if @user.save
            login @user
            redirect_to root_path
        else
            flash[:alert] = "Taki użytkownik już istnieje"
            render :new, status: :unprocessable_entity
        end
    end

    private
    
    # Metoda prywatna definiująca dozwolone parametry dla formularza rejestracyjnego
    def registration_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
