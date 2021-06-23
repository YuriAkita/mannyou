Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end

  namespace :admin do
    resources :users
  end

  resources :users, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :destroy]
end
