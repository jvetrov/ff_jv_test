require 'test_helper'

class CatalogProductsControllerTest < ActionController::TestCase
  setup do
    @catalog_product = catalog_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalog_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalog_product" do
    assert_difference('CatalogProduct.count') do
      post :create, catalog_product: { catalog_id: @catalog_product.catalog_id, product_id: @catalog_product.product_id }
    end

    assert_redirected_to catalog_product_path(assigns(:catalog_product))
  end

  test "should show catalog_product" do
    get :show, id: @catalog_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalog_product
    assert_response :success
  end

  test "should update catalog_product" do
    put :update, id: @catalog_product, catalog_product: { catalog_id: @catalog_product.catalog_id, product_id: @catalog_product.product_id }
    assert_redirected_to catalog_product_path(assigns(:catalog_product))
  end

  test "should destroy catalog_product" do
    assert_difference('CatalogProduct.count', -1) do
      delete :destroy, id: @catalog_product
    end

    assert_redirected_to catalog_products_path
  end
end
