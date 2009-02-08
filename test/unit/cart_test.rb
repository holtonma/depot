require 'test_helper'

class CartTest < ActiveSupport::TestCase
  
  def test_initialize
    cart = Cart.new
    assert_equal 0, cart.items.length
    
  end
  
  def test_add_product
    cart = Cart.new
    cart.add_product products(:one)
    assert 1, cart.items.length
  end
  
  def test_total_price
    cart = Cart.new
    cart.add_product products(:one)
    assert 2324, cart.items[0].price
    assert 2324, cart.total_price
    
    cart.add_product products(:two) #4356
    assert 6680, cart.total_price
    
    cart.add_product products(:one)
    assert 9004, cart.total_price
  end
  
  
  
end
