class ProductVariant < ApplicationRecord
  belongs_to :product
  
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :size, presence: true
  validates :color, presence: true
  validates :material, presence: true
end
