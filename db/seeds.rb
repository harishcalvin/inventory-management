require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

# Clear all data first
ProductVariant.destroy_all
Product.destroy_all
Category.destroy_all
Supplier.destroy_all

# Seed categories and suppliers
4.times do
  category = create(:category)
  supplier = create(:supplier)

  # Create random products for each category/supplier pair
  rand(2..5).times do
    product = create(:product, category: category, supplier: supplier)

    # Create product variants for each product
    rand(1..3).times do
      create(:product_variant, product: product) # Associate product_variant with product
    end
  end
end
