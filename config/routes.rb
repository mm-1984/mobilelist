Rails.application.routes.draw do
 root to: 'toppages#index'
 
 get 'login', to: 'sessions#new'
 post 'login', to: 'sessions#create'
 delete 'logout', to: 'sessions#destroy'
  
 get 'signup', to: 'users#new'
 
 get 'devices/:id/review', to: 'reviews#new'
 
 resources :users, only: [:show, :new, :create] do
        member do
            get :likes
        end
    end
 
 resources :devices
 resources :users
 resources :reviews
 resources :favorites, only: [:create, :destroy]
end
