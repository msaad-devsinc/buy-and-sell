class OrdersController < ApplicationController
  def index
  end

  def new
  	@cart = current_user.cart
  	@products = Product.find(@cart['products'].keys)
  end

  def create
  	# Set your secret key: remember to change this to your live secret key in production
	# See your keys here: https://dashboard.stripe.com/account/apikeys
	Stripe.api_key = 'sk_test_327i6VnfLzFLlkUj0elCxTco005vknis1x'

	# Token is created using Stripe Checkout or Elements!
	# Get the payment token ID submitted by the form:
	token = params[:stripeToken]

	charge = Stripe::Charge.create({
	  amount: current_user.cart['total'].to_i * 100,
	  currency: 'usd',
	  description: 'Example charge',
	  source: token,
	})

	render json: charge
  end
end
