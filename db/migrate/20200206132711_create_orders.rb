class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.float :total, null: false
      t.json :cart, null: false

      t.timestamps
    end
  end
end
