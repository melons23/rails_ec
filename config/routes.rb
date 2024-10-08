# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'products#index'
  resources :products
  resources :carts
  namespace :admin do
    resources :products
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
