class AddCartToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :cart, :json
  end
end
