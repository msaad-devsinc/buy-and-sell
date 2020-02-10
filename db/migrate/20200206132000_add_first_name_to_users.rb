class AddFirstNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :firstName, :string, limit: 25, null: false
    add_column :users, :lastName, :string, limit: 25, null: false
    add_column :users, :phone, :string, limit: 11, null: false
    add_column :users, :cart, :json
  end
end
