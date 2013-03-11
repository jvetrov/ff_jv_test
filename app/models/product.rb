class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :product_picture, :product_picture_attributes, :catalog, :catalogs, :catalog_product, :catalogs_attributes, :catalog_products_attributes
  has_many :catalog_products, :dependent => :destroy
  has_many :catalogs, :through => :catalog_products
  has_one  :product_picture, :dependent => :destroy

  accepts_nested_attributes_for :product_picture, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :catalog_products, :allow_destroy => true

  validates :name, :presence => true
  validates :price, :numericality => { greater_than_or_equal_to: 0 }

end
