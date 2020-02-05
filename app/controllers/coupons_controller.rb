class CouponsController < ApplicationController
  def create
  	@coupon = Coupon.find_by(coupon: params[:discount][:coupon])
  	@msg = ''
  	# @coupon = Coupon.find(1)
  	if @coupon.present?
  		if current_user.cart['discount'].present?
  			@msg = 'already applied'
	  	elsif @coupon.expiry - DateTime.now > 0
	  		total = current_user.cart['total'].to_f
	  		total = total - (total * @coupon.discount)
	  		current_user.cart['total'] = total
	  		current_user.cart['discount'] = @coupon.id
	  		current_user.save
	  		@msg = 'coupon applied'
	  	else
	  		@msg = 'coupon expired'
	  	end
	else
		@msg = 'coupon not found'
	end
  	respond_to do |format|
  		format.js
  	end
  end
end
