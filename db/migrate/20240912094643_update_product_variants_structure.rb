class UpdateProductVariantsStructure < ActiveRecord::Migration[6.1]
  def up
    # Add new columns to product_variants
    add_column :product_variants, :size, :string
    add_column :product_variants, :color, :string
    add_column :product_variants, :material, :string

    # Remove foreign key constraints if they exist
    if foreign_key_exists?(:variant_options, :variants)
      remove_foreign_key :variant_options, :variants
    end
    
    if foreign_key_exists?(:product_variants, :variants)
      remove_foreign_key :product_variants, :variants
    end

    # Drop the tables
    drop_table :variant_options if table_exists?(:variant_options)
    drop_table :variants if table_exists?(:variants)
  end

  def down
    # Recreate the tables
    create_table :variants do |t|
      t.string :name
      t.timestamps
    end

    create_table :variant_options do |t|
      t.references :variant, foreign_key: true
      t.string :name
      t.timestamps
    end

    # Add foreign key constraint back
    add_foreign_key :product_variants, :variants

    # Remove new columns from product_variants
    remove_column :product_variants, :material
    remove_column :product_variants, :color
    remove_column :product_variants, :size
  end
end
