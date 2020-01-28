class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :hash
      t.float :discount
      t.datetime :expiry

      t.timestamps
    end
  end
end
