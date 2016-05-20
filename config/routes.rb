Rails.application.routes.draw do
  root "products#index"
  get "/signup", to: "users#new"
  resources :users, only: [:index, :show, :create]
  resources :products
end
