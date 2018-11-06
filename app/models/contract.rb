class Contract < ApplicationRecord
  belongs_to :vendor
  belongs_to :category
  belongs_to :user

  validates :costs, presence: true, numericality: {greater_than: 0.0}
  validates :vendor, presence: true
  validates :category, presence: true
  validates :ends_on, presence: true
  validate :category_belongs_to_vendor, if: proc{|m| m.vendor_id_changed? || m.category_id_changed?}
  validate :ends_on_is_in_the_future, if: proc{|m| m.ends_on_changed?}

  delegate :name, to: :vendor, prefix: true
  delegate :name, to: :category, prefix: true

  private

  def category_belongs_to_vendor
    unless vendor.vendor_categories.exists?(category_id: category.id)
      errors.add(:category, :confirmation)
    end
  end

  def ends_on_is_in_the_future
    errors.add(:ends_on, :inclusion) if ends_on.present? && ends_on <= Date.today
  end
end
