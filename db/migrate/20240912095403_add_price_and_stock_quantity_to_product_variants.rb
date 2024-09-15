class AddPriceAndStockQuantityToProductVariants < ActiveRecord::Migration[7.2]
  def change
    add_column :product_variants, :price, :decimal, precision: 10, scale: 2 unless column_exists?(:product_variants, :price)
    add_column :product_variants, :stock_quantity, :integer unless column_exists?(:product_variants, :stock_quantity)
  end
end
