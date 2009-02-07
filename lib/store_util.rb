
# shared across models, 

module StoreUtil
  
  def find_cart(cart_in_session)
    cart_in_session ||= Cart.new
  end
  
end
