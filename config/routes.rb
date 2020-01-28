Rails.application.routes.draw do
  get 'orders/index'
  get 'cart/index'
  resources :products do
  	resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
