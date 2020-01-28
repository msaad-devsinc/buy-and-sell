class AddProductToCarts < ActiveRecord::Migration[6.0]
  def change
    add_reference :carts, :product, null: true, foreign_key: true
  end
end
