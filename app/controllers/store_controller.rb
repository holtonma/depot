include StoreUtil

class StoreController < ApplicationController
  
  def index
    find_cart 
    @products = Product.find_products_for_sale
    @cart_id = 1 # for now, no users
  end
  
  def add_to_cart
    @cart = find_cart 
    product = Product.find(params[:id])
    @cart.add_product(product)
  end
  
  private
    def find_cart
      session[:cart] ||= Cart.new
    end
    

end
