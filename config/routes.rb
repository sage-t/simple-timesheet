Rails.application.routes.draw do
  resources :companies
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root 'welcome#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  post 'companies/employ', to: "companies#employ"
  get 'promote', to: "companies#promote"
  get 'demote', to: "companies#demote"
  get 'unemploy', to: "companies#unemploy"
  get 'punch', to: "companies#punch"
  get 'set_company', to: "users#set_company"
  get 'timesheet' => 'companies#timesheet'

end
