Rails.application.routes.draw do
  
  root "welcome#home"
  
  resources :users #generated via Rails g
  
  get '/auth/google_oauth2/callback' => 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
