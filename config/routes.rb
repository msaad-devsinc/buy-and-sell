Rails.application.routes.draw do
  devise_for :users
  resources :products do
  	resources :comments
  end
  resource :orders
  resource :carts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
