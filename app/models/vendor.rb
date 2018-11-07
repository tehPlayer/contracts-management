class Vendor < ApplicationRecord
  has_many :vendor_categories, dependent: :destroy
  has_many :categories, through: :vendor_categories
  has_many :contracts, dependent: :destroy

  def category_exists?(id_or_obj)
    if id_or_obj.is_a?(Category)
      vendor_categories.exists?(category_id: id_or_obj.id)
    else
      vendor_categories.exists?(category_id: id_or_obj)
    end
  end
end
