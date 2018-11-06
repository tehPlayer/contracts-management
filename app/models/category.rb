class Category < ApplicationRecord
  has_many :vendor_categories, dependent: :destroy
  has_many :vendors, through: :vendor_categories
  has_many :contracts, dependent: :destroy
end
