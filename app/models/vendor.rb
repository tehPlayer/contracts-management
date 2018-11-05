class Vendor < ApplicationRecord
  has_many :vendor_categories, dependent: :destroy
  has_many :categories, through: :vendor_categories
  has_many :contracts, dependent: :destroy
end
