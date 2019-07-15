Rails.application.routes.draw do
  
  root "sessions#new"

  get '/auth/facebook/callback' => 'sessions#create'

  resources :users, except: [:destroy] do
    resources :teams, except: [:index]
  end

  resources :teams, except: [:show]

  resources :players, only: [:index, :create, :show, :update, :destroy]

  scope '/admin' do
    resources :players, only: [:new, :edit]
  end

  get '/players/:id/previous' => 'players#previous'
  get '/players/:id/next' => 'players#next'
  get '/free-agents' => 'players#free_agents'
  post '/add-players' => 'players#add_to_team'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
