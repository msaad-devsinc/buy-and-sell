class CouponsController < ApplicationController
  def create
  	@coupon = Coupon.find_by(coupon: params[:discount][:coupon])
    @cart = current_user.cart
  	# @coupon = Coupon.find(1)
  	if @coupon.present?
  		if current_user.cart['discount'].present?
  			flash[:alert] = 'already applied'
	  	elsif @coupon.expiry - DateTime.now > 0
	  		current_user.cart['discount'] = @coupon.id
	  		current_user.save
	  		flash[:alert] = 'coupon applied'
	  	else
	  		flash[:alert] = 'coupon expired'
	  	end
	 else
	   	flash[:alert] = 'coupon not found'
	 end
  end
end
