Rails.application.routes.draw do
  
  
  root "welcome#home"
  
  resources :users, only: [:show, :edit, :update, :index, :destroy] #generated via Rails g
  resources :matches, only: [:new, :create, :show, :destroy]
  
  get '/auth/google_oauth2/callback' => 'sessions#create'
  
  get '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
