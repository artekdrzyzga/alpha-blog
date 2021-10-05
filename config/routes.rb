Rails.application.routes.draw do
  resources :articles
  #resources :users
  get 'about', to: 'pages#about'
 
  root to:'pages#home'
  resources :articles, only: [:show]
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
end
