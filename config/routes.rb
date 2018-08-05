Rails.application.routes.draw do
  
  
  
  root "welcome#home"
  

  resources :users, only: [:new, :create, :edit, :update, :show, :index, :destroy] do
    resources :matches, only: [:create, :show, :index, :destroy]
    resources :games, only: [:create,:show, :update]
  end
  
  resources :matches, only: [:show, :destroy]
  resources :games, only: [:new, :create, :show, :update]

  
  get '/auth/google_oauth2/callback' => 'sessions#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/users/:id/data' => 'users#data'
  get '/logout' => 'sessions#destroy'
  get '/most_matches' => 'users#most_matches'
  get '/leaders' => 'users#leaders'
  get '/users/:id/active_games' => 'users#active_games'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
