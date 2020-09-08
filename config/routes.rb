Rails.application.routes.draw do
 root to: 'toppages#index'
 
 get 'login', to: 'sessions#new'
 post 'login', to: 'sessions#create'
 delete 'logout', to: 'sessions#destroy'
  
 get 'signup', to: 'users#new'
 
 get 'devices/:id/review', to: 'reviews#new'
 
 resources :devices
 resources :users
 resources :reviews
 
end
