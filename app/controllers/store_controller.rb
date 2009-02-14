
class StoreController < ApplicationController
  
  def index
    find_cart
    @cart = find_cart 
    @products = Product.find_products_for_sale
    @cart_id = 1 # for now, no users
  end
  
  # moved to items_controller#create
  # def add_to_cart
  #   # @cart = find_cart 
  #   # product = Product.find(params[:id])
  #   # @cart.add_product(product)
  # end
  def checkout
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Your cart is empty")
    else
      @order = Order.new
    end
  end
  
  
  private
    def find_cart
      session[:cart] ||= Cart.new
    end
    
end
