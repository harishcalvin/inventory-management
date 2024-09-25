class Sale < ApplicationRecord
  has_many :sold_items, dependent: :destroy
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true

end
