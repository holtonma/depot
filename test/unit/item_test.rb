require 'test_helper'

class CartTest < ActiveSupport::TestCase
  
  def setup
    @item = Item.new(products(:one))
  end
  
  def test_initialize
    assert_equal 1, @item.quantity
    assert_equal products(:one), @item.product
  end
  
  def test_increment_quantity
    @item.increment_quantity
    assert_equal 2, @item.quantity
  end
  
  def test_title
    assert_equal "Golf My Way", @item.title
  end
  
  def test_price
    @item.increment_quantity
    assert_equal 2, @item.quantity
    
    assert_equal 2324*2, @item.price
  end
  
end
