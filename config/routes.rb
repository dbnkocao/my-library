Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs"

  resource :session
  resources :users, only: %i[new create] do
    get :edit, on: :collection
    patch :update, on: :collection
  end
  resources :books, only: :create do
    post :search_prices
  end
  resources :passwords, param: :token

  resources :libraries, only: :index do
    delete "delete_book/:book_id" => "libraries#delete_book", as: :delete_book, on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check




  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "libraries#index"
end
