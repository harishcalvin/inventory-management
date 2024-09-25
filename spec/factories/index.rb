# spec/factories/index.rb
FactoryBot.define do
  # Category Factory
  factory :category do
    name { Faker::Commerce.department }
    gst { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end

  # Supplier Factory
  factory :supplier do
    name { Faker::Company.name }
  end

  # Product Factory
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    category
    supplier
  end

  # Product Variant Factory
  factory :product_variant do
    product # This ensures the product_variant belongs to a product
    price { Faker::Commerce.price(range: 10..100.0, as_string: true) }
    stock_quantity { Faker::Number.between(from: 1, to: 100) }
    size { Faker::Commerce.material }
    color { Faker::Color.color_name }
    material { Faker::Commerce.product_name }
  end
end
