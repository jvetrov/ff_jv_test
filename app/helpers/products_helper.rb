module ProductsHelper
  def setup_product(product)
    product.product_picture ||= ProductPicture.new

    product_catalogs = product.catalog_products

    (Catalog.all).each do |catalog|
      exists = false
      product_catalogs.each do |catalog_product|
        if catalog_product.catalog_id == catalog.id
          exists = true
        end
      end
      unless exists
        product.catalog_products.build(:catalog => catalog)
      end
    end
    product.catalog_products.sort_by! { |x| x.catalog.name }
    
    product   
  end
end
