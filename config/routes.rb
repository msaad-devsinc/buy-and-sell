Rails.application.routes.draw do
  get 'coupon/create'
  devise_for :users
  resources :products do
  	resources :comments
  end
  resource :orders
  resource :carts
  resource :coupon
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
