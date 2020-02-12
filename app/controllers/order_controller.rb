class OrderController < ApplicationController
  before_action :get_cart_and_products, only: [:new,:create]

  def new
    @coupon = Coupon.find_by(id:@cart['discount'])
  end

  def create
  	charge = Stripe::Charge.create(stripe_params)
    if charge['status'] == 'succeeded'
      current_user.orders.create(total:@cart['total'],cart:@cart)
      Order.update_inventory(@cart)
      Cart.empty(current_user)
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

    def stripe_params
      discount = Coupon.apply_discount(current_user)
      {
        amount: ((current_user.cart['total'].to_f - discount) * 100).to_i,
        currency: 'usd',
        description: current_user.email,
        source: params[:stripeToken],
      }
    end
end
