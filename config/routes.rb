Rails.application.routes.draw do
  get 'passwords/edit'
  get 'passwords/update'
  get 'passwords/password_params'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
    resource :registration
    resource :session
    resource :new_pasword_reset
    resource :password

    root "main#index"
end
  