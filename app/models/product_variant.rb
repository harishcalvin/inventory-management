class ProductVariant < ApplicationRecord
  belongs_to :products
  belongs_to :variants
end
