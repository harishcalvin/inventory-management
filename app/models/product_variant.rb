class ProductVariant < ApplicationRecord
  belongs_to :product
  has_many :sold_items
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :variant_value_present

  def variant_type
    return "Size" if size.present?
    return "Color" if color.present?
    return "Material" if material.present?
    nil
  end

  def default_variant?
    self.size === "Default" && !self.color && !self.material
  end

  private

  def variant_value_present
    errors.add(:base, "At least one of size, color, or material must be present") unless size.present? || color.present? || material.present?
  end
end
