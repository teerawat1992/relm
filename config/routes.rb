Rails.application.routes.draw do
  root "store#index", as: :store
  get "/signup", to: "users#new"
  resources :users, only: [:index, :show, :create]
  resources :products
end
