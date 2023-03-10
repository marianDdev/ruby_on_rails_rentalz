Rails.application.routes.draw do
  
  resources :properties
  get '/my_properties', to: 'properties#my_properties'
  root 'properties#index'
  
  get '/signup', to: 'users#new'
  resources :users

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/dashboard', to: 'pages#dashboard'

  resources :bookings
  patch '/bookings/:id/approve', to: 'bookings#approve', as: 'approve'
  patch '/bookings/:id/decline', to: 'bookings#decline', as: 'decline'

end
