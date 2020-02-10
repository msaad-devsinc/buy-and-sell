class Coupon < ApplicationRecord

	validates :coupon,
			presence: true,
			length: { maximum: 20 }
	validates :expiry,
			presence: true
	validates :discount,
			presence: true,
			numericality: true

  def self.apply_discount(current_user)
    coupon = Coupon.find(current_user.cart['discount'])
    total = current_user.cart['total'].to_f
    total * coupon.discount
  end
end
