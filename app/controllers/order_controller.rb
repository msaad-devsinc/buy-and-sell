class OrderController < ApplicationController
  before_action :get_cart_and_products, only: [:new,:create]

  def new
    @coupon = Coupon.find_by(id:@cart['discount'])
  end

  def create
  	token = params[:stripeToken]
    disc = Coupon.apply_discount(current_user)
  	charge = Stripe::Charge.create({
  	  amount: ((current_user.cart['total'].to_f - disc) * 100).to_i,
  	  currency: 'usd',
  	  description: current_user.email,
  	  source: token,
  	})
    if charge['status'] == 'succeeded'
      current_user.orders.create(total:@cart['total'],cart:@cart)
      Order.update_inventory(@cart)
      Cart.empty_cart(current_user)
      render :thankyou
    else
      render :retry
    end
  end

  def thankyou
  end

  def retry
  end

  private
    def get_cart_and_products
      @cart = current_user.cart
      @products = Product.find(@cart['products'].keys)
    end
end
