Rails.application.routes.draw do
  devise_for :users
  resources :products do
  	resources :comments
  end
  resource :order, controller: 'order', as: 'orders'
  resource :cart, controller: 'cart', as: 'carts'
  resource :coupon
  resource :account, controller: 'account'
  root 'products#home'
  get "/about", to: 'static#about'
  get "/contact", to: 'static#contact'
end
