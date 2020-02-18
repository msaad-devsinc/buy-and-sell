Rails.application.routes.draw do
  devise_for :users
  resources :products do
  	resources :comments
  end
  resource :order, controller: 'order', as: 'orders'
  resource :cart, controller: 'cart', as: 'carts'
  resource :coupon
  resource :account, controller: 'account'
  resources :about, controller: 'pages' , only:[:index]
  # resources :contact, controller: 'pages' , only:[:index]
  # resource :pages, only:[] do
  #   get :about , '/about'
  # end
  root 'products#home'
  get "/about", to: 'pages#about'
  get "/contact", to: 'pages#contact'
end
