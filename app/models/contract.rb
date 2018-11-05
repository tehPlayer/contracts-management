class Contract < ApplicationRecord
  belongs_to :vendor
  belongs_to :category
  belongs_to :user

  validate :category_belongs_to_vendor, if: proc{|m| m.vendor_id_changed? || m.category_id_changed?}

  private

  def category_belongs_to_vendor
    unless vendor.vendor_categories.exists?(category_id: category.id)
      errors.add(:category, :confirmation)
    end
  end
end
