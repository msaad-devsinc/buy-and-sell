class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.float :discount, null: false
      t.datetime :expiry, null: false
      t.string :coupon, limit: 20, null: false

      t.timestamps
    end
  end
end
