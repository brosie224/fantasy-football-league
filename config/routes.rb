Rails.application.routes.draw do
  
  root "sessions#new"

  resources :users, except: [:destroy] do
    resources :teams, except: [:index]
  end

  resources :teams, except: [:show]

  resources :players, except: [:index, :show]

  get '/free-agents', to: 'players#index'
  post '/players', to: 'players#add_to_team'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
