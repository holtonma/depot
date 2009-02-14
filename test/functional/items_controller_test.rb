require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  fixtures :products
  
  test "posting to cart_items adds a product to the cart, and that cart item has a price and quantity" do
    post :create, :cart_id => 1, :id => products(:one).id
    assert_response :redirect
    assert cart = assigns(:cart)
    assert_equal 1, cart.items.length
    assert_equal 2324, cart.items[0].price
    assert_equal 1, cart.items[0].quantity
  end
  
  test "emptying cart should remove all products from cart, and display 'emtpy cart' message" do
  end
  
  
end
