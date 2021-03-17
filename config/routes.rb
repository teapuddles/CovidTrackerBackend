Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :locations, only: [:index, :show, :update]
  resources :stories, only: [:index, :show]
  resources :users, only: [:index, :show, :create, :update, :destroy]
  
  post "/login", to: "users#login"
  put "/update_location", to: "users#update_location"
  get "/persist", to: "users#persist"

end
