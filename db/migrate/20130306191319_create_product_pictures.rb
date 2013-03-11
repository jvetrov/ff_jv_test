class CreateProductPictures < ActiveRecord::Migration
  def change
    create_table :product_pictures do |t|
      t.integer :product_id
      t.string :url

      t.timestamps
    end
  end
end
