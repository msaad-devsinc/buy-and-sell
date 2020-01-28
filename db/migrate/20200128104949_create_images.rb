class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.references :imagable, polymorphic: true, null: false
      t.string :path

      t.timestamps
    end
  end
end
