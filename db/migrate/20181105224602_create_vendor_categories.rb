class CreateVendorCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :vendor_categories do |t|
      t.references :vendor, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
