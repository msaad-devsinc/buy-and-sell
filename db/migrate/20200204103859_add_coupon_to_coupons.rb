class AddCouponToCoupons < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :coupon, :string
  end
end
