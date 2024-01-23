class ApplicationController < ActionController::Base

    private

    # Sprawdza, czy użytkownik jest zalogowany; jeśli nie, przekierowuje na stronę główną z komunikatem
    def authenticate_user!
        redirect_to root_path, alert: "Musisz się zalogować, żeby z tego korzystać" unless user_signed_in?  
    end 

    # Zwraca aktualnie zalogowanego użytkownika
    def current_user
        Current.user ||= authenticate_user_from_session
    end
    helper_method :current_user

    # Sprawdza sesję użytkownika i zwraca obiekt użytkownika, jeśli istnieje
    def authenticate_user_from_session
        User.find_by(id: session[:user_id]) 
    end

    # Sprawdza, czy użytkownik jest zalogowany
    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?

    # Loguje użytkownika: ustawia obecnie zalogowanego użytkownika, resetuje sesję i ustawia nowy identyfikator sesji
    def login(user)
        Current.user = user
        reset_session
        session[:user_id] = user.id
    end

    # Wylogowuje użytkownika: resetuje sesję
    def logout(user)
        Current.user = user
        reset_session
    end
end
