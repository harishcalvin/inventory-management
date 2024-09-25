# app/models/sale.rb
# class Sale < ApplicationRecord
#   has_many :sold_items, dependent: :destroy
#   accepts_nested_attributes_for :sold_items

#   validates :date, presence: true
#   validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
# end

# app/models/sold_item.rb
class SoldItem < ApplicationRecord
  belongs_to :sale
  belongs_to :product_variant
  belongs_to :product_variant, optional: true

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end

# app/models/product_variant.rb
# class ProductVariant < ApplicationRecord
#   belongs_to :product

#   def display_name
#     "#{product.name} - #{size} #{color} #{material}"
#   end
# end
