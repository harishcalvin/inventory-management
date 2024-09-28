class SoldItem < ApplicationRecord
  belongs_to :sale
  belongs_to :product_variant, optional: true
  
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def product
    @product ||= Product.unscoped.find_by(id: product_variant&.product_id)
  end

  def product_name
    product&.name || "Product Unavailable"
  end
end