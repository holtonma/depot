class CartController < ApplicationController
  
  def new
    # new_cart() /cart/new # create a new cart
  end

  def show
    # cart()  ... get /cart/:id  # grab and display contents of the cart
    @cart = find_cart
  end
  
  # removing this non-RESTful noise
  # def add_product
  #   # add items to cart here
  #   @cart = find_cart
  #   product = Product.find(params[:id])
  #   @cart.add_product(product)
  # end
  
  private
    def find_cart
      session[:cart] ||= Cart.new
    end
  
end
