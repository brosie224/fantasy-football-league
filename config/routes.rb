Rails.application.routes.draw do
  
  root "sessions#new"

  resources :users, except: [:destroy] do
    resources :teams, except: [:index]
  end

  resources :teams

  # resources :players
  get '/players', to: 'players#index'
  post '/players', to: 'players#add_to_team'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
