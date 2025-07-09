Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index" # Assuming you want this as your homepage

  # Devise routes for user authentication
  devise_for :users

  # Resource routes for your models (e.g., posts, comments, likes, categories)
  resources :posts do
    # Example nested resources, if applicable
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :categories # If categories are top-level resources

  # You likely don't need `resources :post_categories` as it's often a join table.

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Add any other custom routes here as needed
end
