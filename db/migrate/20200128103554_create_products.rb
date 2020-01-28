class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :category
      t.text :description
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
