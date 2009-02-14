require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  def test_from_cart_item
    cart_item = CartItem.new(products(:one))
    line_item = LineItem.from_cart_item(cart_item)
 
    assert_equal products(:one), line_item.product
    assert_equal 1, line_item.quantity
    assert_equal products(:one).price, line_item.total_price
  end
 
  def test_from_cart_item_with_many_of_the_same_products
    product = products(:one)
 
    cart_item = CartItem.new(product)
    cart_item.increment_quantity
 
    line_item = LineItem.from_cart_item(cart_item)
 
    assert_equal product, line_item.product
    assert_equal 2, line_item.quantity
    assert_equal cart_item.price, line_item.total_price
  end
 
  def test_line_item_can_has_order
    line_item = line_items(:one)
    line_item.order = orders(:two)
    line_item.save!
    assert_equal(orders(:two), line_item.order)
  end
end
