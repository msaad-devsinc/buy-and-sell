class RemoveHashFromCoupons < ActiveRecord::Migration[6.0]
  def change

    remove_column :coupons, :hash, :string
  end
end
