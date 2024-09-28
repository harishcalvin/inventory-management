class Product < ApplicationRecord
  belongs_to :category
  belongs_to :supplier
  has_many :product_variants, dependent: :restrict_with_error
  has_many :sold_items, through: :product_variants
  accepts_nested_attributes_for :product_variants, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :supplier_id, presence: true

  # Soft delete functionality
  default_scope { where(deleted_at: nil) }
  scope :with_deleted, -> { unscoped }

  def soft_delete
    update(deleted_at: Time.current)
  end

  def restore
    update(deleted_at: nil)
  end

  def soft_deleted?
    deleted_at.present?
  end

  # Class method to get a product, including soft-deleted ones
  def self.find_with_deleted(id)
    unscoped.find(id)
  end

  # Other methods
  def default_variant
    first_variant = product_variants.first
    first_variant if first_variant&.default_variant?
  end
end