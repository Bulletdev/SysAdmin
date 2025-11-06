# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  # Admin routes
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :users do
      member do
        patch :toggle_role
      end
      collection do
        post :import
        get :import_progress
      end
    end
  end

  # User profile route
  resource :user_profile, only: %i[show edit update destroy]

  # Solutions (Umanni simplificada)
  get '/solutions', to: 'solutions#index'
  scope '/solutions' do
    get '/succession', to: 'solutions#succession'
    get '/evaluations', to: 'solutions#evaluations'
    get '/goals', to: 'solutions#goals'
    get '/feedbacks', to: 'solutions#feedbacks'
    get '/pdi', to: 'solutions#pdi'
    get '/talent_matrix', to: 'solutions#talent_matrix'
  end
end
