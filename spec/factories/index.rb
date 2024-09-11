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
    category_id { Category.all.sample.id } # Random category
    supplier_id { Supplier.all.sample.id } # Random supplier
  end
end
