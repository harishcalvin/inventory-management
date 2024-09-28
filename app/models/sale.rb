class Sale < ApplicationRecord
  has_many :sold_items, dependent: :destroy
  has_many :product_variants, through: :sold_items
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true
end
