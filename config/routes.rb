Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Root - Welcome screen
  root "welcome#index"

  # Mode selection (solo vs group)
  get "mode/select", to: "modes#select", as: :select_mode
  post "mode/choose", to: "modes#choose", as: :choose_mode

  # Oblique Strategies
  get "oblique", to: "obliques#show", as: :oblique
  get "oblique/random", to: "obliques#random", as: :random_oblique

  # Galaxy selection
  get "galaxies", to: "galaxies#index", as: :galaxies
  post "galaxies/choose", to: "galaxies#choose", as: :choose_galaxy
  post "galaxies/random", to: "galaxies#random", as: :random_galaxy

  # Sessions (main question flow)
  resources :sessions, only: [:show, :create] do
    member do
      get :prompt
      post :next_question
      post :save_reflection
      post :skip_question
      get :constellation
      post :complete
    end
  end

  # Reflections (view past sessions)
  resources :reflections, only: [:index, :show]
end
