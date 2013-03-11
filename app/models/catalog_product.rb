class CatalogProduct < ActiveRecord::Base
  attr_accessible :catalog_product_id, :catalog_id, :product_id, :catalog
  belongs_to :product
  belongs_to :catalog

end
