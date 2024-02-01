# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'orders#index'

  resources :orders, only: %i[index show]
  post 'orders/checkout', to: 'orders#checkout'
  get 'orders/callback', to: 'orders#callback'
end
