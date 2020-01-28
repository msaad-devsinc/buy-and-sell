class AddCouponToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :coupon, null: true, foreign_key: true
  end
end
