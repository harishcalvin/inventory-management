class Product < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  has_many :product_variants, dependent: :destroy
end
