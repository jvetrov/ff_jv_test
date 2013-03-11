class Catalog < ActiveRecord::Base
  attr_accessible :catalog_id, :name, :catalog_products_attributes, :products_attributes
  has_many :catalog_products, :dependent => :destroy
  has_many :products, :through => :catalog_products
end
