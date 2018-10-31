Rails.application.routes.draw do
  resources :companies
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root 'welcome#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

end
