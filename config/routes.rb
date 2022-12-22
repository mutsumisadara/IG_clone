Rails.application.routes.draw do
  root 'users#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
end