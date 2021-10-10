Rails.application.routes.draw do
  resources :articles
  #resources :users
  get 'about', to: 'pages#about'
 
  root to:'pages#home'
  resources :articles, only: [:show]
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
