Rails.application.routes.draw do
  
  root "sessions#new"

  get '/auth/facebook/callback' => 'sessions#create'

  resources :users, except: [:destroy] do
    resources :teams, except: [:index]
  end

  resources :teams, except: [:show]

  scope '/admin' do
    resources :players, except: [:index, :show]
  end

  get '/admin/all-players' => 'players#all_players'
  get '/free-agents' => 'players#index'
  post '/add-players' => 'players#add_to_team'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
