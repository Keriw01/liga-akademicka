Rails.application.routes.draw do
  get 'team_members/create'
  get 'team_members/destroy'
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
        delete 'remove_user/:user_id', to: 'teams#remove_user', as: 'remove_user'
        post 'add_user/:user_id', to: 'teams#add_user', as: 'add_user'
      end
    end
    root "main#index"
end
  