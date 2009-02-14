require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  
  test "order contains name" do
    order = orders(:one)
    order.name = ""
    assert ! order.valid?
    assert order.errors.on(:name)
  end
  
  test "order contains address" do
    order = orders(:one)
    order.address = "335 Nora Ave"
    assert order.save!
  end
  
  test "order without address throws an error" do
    order = orders(:one)
    order.address = ""
    assert ! order.valid?
    assert order.errors.on(:address)
  end
  
  test "bogus pay type throws an error" do
    order = orders(:one)
    order.pay_type = "asdfasdf"
    assert ! order.valid?
    assert order.errors.on(:pay_type)
  end

  test "order validates presence of email" do
    order = orders(:one)
    order.email = ""
    assert ! order.valid?
    assert order.errors.on(:email)
  end
  
end
