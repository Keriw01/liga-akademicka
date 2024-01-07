Rails.application.routes.draw do
  get 'teams/join'
  get 'profiles/show'
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
    resource :profile, only: [:show]
    post 'join_team', to: 'teams#join'
    resources :teams do
      member do
        post 'choose_team', to: 'teams#choose_team'
      end
    end
    root "main#index"
end
  