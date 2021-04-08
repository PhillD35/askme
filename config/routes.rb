Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get '/show', to: 'users#show'

  resources :users
  resources :questions

  root 'users#index'
end
