
Rails.application.routes.draw do
  # Defines the root path route ("/")
  # root "pages#home" # Delete or comment out this line
  root "posts#index" # Add or uncomment this line

  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


# config/routes.rb

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  # Defines all standard RESTful routes for the Post resource
  resources :posts

 2d32fe77661cbb6d5c2f23a40816540019075e13
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # Defines the root path route ("/")
  # root "articles#index"
end

  # Defines routes for Turbo Native navigation
  # See https://turbo.hotwired.dev/handbook/native#--turbo-native-navigation
  # for more information.
  namespace :turbo do
    namespace :native do
      get "recede_historical_location", to: "navigation#recede"
      get "resume_historical_location", to: "navigation#resume"
      get "refresh_historical_location", to: "navigation#refresh"
    end
  end

  # Defines routes for Action Mailbox ingresses
  # See https://guides.rubyonrails.org/action_mailbox_basics.html for more information.
  mount ActionMailbox::Engine => "/rails/action_mailbox"

  # Defines routes for Active Storage
  # See https://guides.rubyonrails.org/active_storage_overview.html for more information.
  mount ActionText::Engine => "/rails/action_text"
end
 2d32fe77661cbb6d5c2f23a40816540019075e13
