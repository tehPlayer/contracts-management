class Contract < ApplicationRecord
  belongs_to :vendor
  belongs_to :category
  belongs_to :user
end
