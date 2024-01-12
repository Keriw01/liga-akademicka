class ProfilesController < ApplicationController
  
  # Akcja która będzie obsługiwać wyświetlanie profilu użytkownika.
  def show
    @user = current_user
  end
end
