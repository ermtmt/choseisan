Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'top', to: 'home#top', as: :top
  resources :events do
    resource :entry, controller: :event_entry, only: [:create, :update, :destroy]
  end
  resources :tags, except: [:show]
end

