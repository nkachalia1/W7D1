Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "cats#index"

  resources :users, only: %i(create new)
  resource :session, only: %i(create new destroy)

  resources :cats, except: :destroy do
    resources :cat_rental_requests, only: [:new]
  end
  resources :cat_rental_requests, only: [:new, :create] do
    member do
      post :approve
      post :deny
    end
  end
end
