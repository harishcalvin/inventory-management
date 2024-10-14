require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

# Clear all existing data
ProductVariant.destroy_all
Product.destroy_all
Category.destroy_all
Supplier.destroy_all

# Manually create categories
categories = [
  { name: 'Electronics' },
  { name: 'Clothing' },
  { name: 'Home & Kitchen' },
  { name: 'Books' },
  { name: 'Sports' }
]

categories.each do |category_attributes|
  create(:category, category_attributes)
end

# Manually create suppliers
suppliers = [
  { name: 'Supplier A' },
  { name: 'Supplier B' },
  { name: 'Supplier C' },
  { name: 'Supplier D' }
]

suppliers.each do |supplier_attributes|
  create(:supplier, supplier_attributes)
end

# Create random products for each category/supplier pair
Category.find_each do |category|
  Supplier.find_each do |supplier|
    rand(2..5).times do
      product = create(:product, category: category, supplier: supplier)

      # Create product variants for each product
      rand(1..3).times do
        create(:product_variant, product: product) # Associate product_variant with product
      end
    end
  end
end
