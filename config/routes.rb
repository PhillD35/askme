Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users
  resources :sessions, only: %i(new create destroy)
  resources :questions, except: %i(show new index)

  get 'log_in', to: 'sessions#new'
  get 'log_out', to: 'sessions#destroy'

  get 'sign_up', to: 'users#new'

  root 'users#index'
end
