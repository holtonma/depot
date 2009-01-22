require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "that product has a price" do
    product = products(:one)
    product.price = 100
    assert product.save!
  end
  
  test "it gets angry if no title" do
    product = products(:one)
    product.title = nil
    assert !product.valid?
    assert product.errors.on(:title)
  end
  
end
