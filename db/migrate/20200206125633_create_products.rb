class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title, limit: 30
      t.string :category, limit: 15
      t.text :description, limit: 250
      t.decimal :price, null: false
      t.integer :quantity, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
