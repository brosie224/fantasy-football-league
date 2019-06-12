Rails.application.routes.draw do
  
  root "sessions#new"

  get '/auth/facebook/callback' => 'sessions#create'

  resources :users, except: [:destroy] do
    resources :teams, except: [:index]
  end

  resources :teams, except: [:show]

  resources :players, except: [:index, :show]

  get '/free-agents' => 'players#index'
  post '/add-players' => 'players#add_to_team'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
