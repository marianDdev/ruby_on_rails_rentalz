Rails.application.routes.draw do
  
  resources :properties
  root 'properties#index'
  
  get '/signup', to: 'users#new'
  resources :users

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
