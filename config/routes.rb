Rails.application.routes.draw do
  resources :homes
  # devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification',  registration: 'register', sign_up: 'cmon_let_me_in' }
  root to: "cars#index"
  
  resources :cars
  resources :models
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
