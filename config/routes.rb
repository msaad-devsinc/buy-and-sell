Rails.application.routes.draw do
  # get 'account/show'
  # get 'coupon/create'
  devise_for :users
  resources :products do
  	resources :comments
  end
  resource :orders
  resource :carts
  resource :coupon
  resource :account, controller: 'account'

  root 'products#home'

  # get 'orders/thankyou' , to: 'orders#thankyou'
  # get 'orders/retry' , to: 'orders#retry'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
