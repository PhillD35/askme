Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/show', to: 'users#show'

  resources :users, except: :destroy
  resources :questions
  resources :sessions, only: %i(new create destroy)

  get 'log_in' => 'sessions#new'
  get 'log_out' => 'sessions#destroy'

  get 'sign_up' => 'users#new'

  root 'users#index'
end
