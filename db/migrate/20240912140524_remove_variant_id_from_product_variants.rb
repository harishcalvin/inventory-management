class RemoveVariantIdFromProductVariants < ActiveRecord::Migration[7.2]
  def change
    remove_column :product_variants, :variant_id, :integer
  end
end
