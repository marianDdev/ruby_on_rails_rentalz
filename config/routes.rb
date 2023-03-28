Rails.application.routes.draw do
  resources :reviews

  resources :messages

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
  get '/thanks', to: 'pages#thanks'
  get '/help', to: 'pages#help'
  get '/help/owner', to: 'pages#owner_help', as: 'owner_help'
  get '/help/guest', to: 'pages#guest_help', as: 'guest_help'

  resources :bookings
  patch '/bookings/:id/approve', to: 'bookings#approve', as: 'approve'
  patch '/bookings/:id/decline', to: 'bookings#decline', as: 'decline'
end
