class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.references :vendor, foreign_key: true
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true
      t.float :costs
      t.datetime :ends_on

      t.timestamps
    end
  end
end
