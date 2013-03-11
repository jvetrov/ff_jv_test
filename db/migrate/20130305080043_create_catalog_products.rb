class CreateCatalogProducts < ActiveRecord::Migration
  def change
    create_table :catalog_products do |t|
      t.integer :product_id
      t.integer :catalog_id

      t.timestamps
    end
  end
end
