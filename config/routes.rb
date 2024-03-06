Rails.application.routes.draw do

  root 'routes#index'
  
  post 'search', to: 'routes#search', as: 'search' 
  post 'pnr', to: 'routes#pnr', as: 'pnr' 
  get 'payment', to: 'tickets#payment'
  get 'trainroute', to: 'routes#trainroute'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # post "ticket/:route_id" ,to: 'tickets#create' ,as: 'createticket' 

  resources :routes do 
    resources :stations
    resources :tickets 
  end

  resources :tickets do 
    resources :passengers 
  end
 
end

