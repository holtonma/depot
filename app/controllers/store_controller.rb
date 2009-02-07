include StoreUtil

class StoreController < ApplicationController
  
  def index
    StoreUtil.find_cart(session[:cart])
    @products = Product.find_products_for_sale
    @cart_id = 1 # for now, no users
  end
  
  def add_to_cart
    @cart = StoreUtil.find_cart(session[:cart]) 
    product = Product.find(params[:id])
    @cart.add_product(product)
  end

end
