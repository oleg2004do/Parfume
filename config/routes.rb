Rails.application.routes.draw do
  # Home page and other static pages
  get "home/index"
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  # User authentication routes
  get '/login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  post '/login', to: 'sessions#create'

  # User profile routes
  get 'profile', to: 'users#show', as: 'profile'
  get 'profile/edit', to: 'users#edit', as: 'edit_profile'
  patch 'profile', to: 'users#update', as: 'update_profile'
  
  # Contact us page
  get '/contact_us', to: 'pages#contact_us', as: 'contact_us'

  # Resources for users, products, orders, and carts
  resources :users, only: [:new, :create]

  # Products resource with nested review routes
  resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    post 'create_review', on: :member  # Route for creating reviews
    resources :reviews, only: [:create]  # Nested resource for reviews
  end

  # Orders and checkouts resources
  resources :orders, only: [:new, :create, :show]
  resources :checkouts, only: [:new, :create, :show]

  # Cart actions (add/remove items)
  resource :cart, only: [:show] do
    get 'add_item/:product_id', to: 'carts#add_item', as: :add_item
    get 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
  end
  
  

  # Set root route to home page
  root "home#index"
end
