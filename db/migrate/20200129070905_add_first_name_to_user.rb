class AddFirstNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :firstName, :string
    add_column :users, :lastName, :string
    add_column :users, :phone, :string
  end
end
