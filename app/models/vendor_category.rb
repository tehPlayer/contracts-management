# frozen_string_literal: true

class VendorCategory < ApplicationRecord
  belongs_to :vendor
  belongs_to :category
end
