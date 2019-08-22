class CreateProducts < ActiveRecord::Migration[4.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :image
      t.integer :price_cents
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
