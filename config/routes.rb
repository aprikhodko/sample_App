UserAuth::Application.routes.draw do

  match ':controller(/:action(/:id))(.:format)'
  root :to => 'sessions#login'
  match "signup", :to => "users#new"
  match "login", :to => "sessions#login"
  match "logout", :to => "sessions#logout"
  match "home", :to => "sessions#home"
  match "profile", :to => "sessions#profile"
  match "setting", :to => "sessions#setting"
end
  
  get 'users#new'
 
   devise_for :users
  
    authenticated :user do
      root 'users#index'
    end
  
    unauthenticated :user do
      devise_scope :user do
        get "/" => "devise/sessions#new"
      end
    end
  
    resources :conversations do
      resources :messages
end
