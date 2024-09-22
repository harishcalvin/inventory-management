class SoldItem < ActiveRecord::Migration[7.2]
  def change
    create_table :sold_items do |t|
      t.references :sale, null: false, foreign_key: true
      t.references :product_variant, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.decimal :price, null: false
      t.timestamps
    end
  end
end