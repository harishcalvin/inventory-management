require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

Product.destroy_all
Category.destroy_all
Supplier.destroy_all

4.times do
  category = create(:category)
  supplier = create(:supplier)

  # Random number of phases between 2 and 14
  rand(100).times do
    create(:product, category: category, supplier: supplier)
  end
end
