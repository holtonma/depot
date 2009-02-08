require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  
  test "posting to cart_items adds a product to the cart" do
    post :create, :cart_id => 1, :id => products(:one).id
    assert_response :redirect
    assert cart = assigns(:cart)
    assert_equal 1, cart.items.length
  end
  
  
end
