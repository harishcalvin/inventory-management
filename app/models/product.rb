class Product < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  has_many :product_variants, dependent: :destroy
  
  accepts_nested_attributes_for :product_variants, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true

  def default_variant
    first_variant = product_variants.first

    first_variant if first_variant.default_variant?
  end
end
