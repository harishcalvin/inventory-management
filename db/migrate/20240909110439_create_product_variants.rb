class CreateProductVariants < ActiveRecord::Migration[7.2]
  def change
    create_table :product_variants do |t|
      t.references :products, null: false, foreign_key: true
      t.references :variants, null: false, foreign_key: true
      t.decimal :price
      t.integer :stock_quantity

      t.timestamps
    end
  end
end
