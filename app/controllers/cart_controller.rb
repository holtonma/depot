include StoreUtil

class CartController < ApplicationController
  layout "store"
   
  def new
    # new_cart() /cart/new # create a new cart
  end

  def show
    # cart()  ... get /cart/:id  # grab and display contents of the cart
    @cart = StoreUtil.find_cart(session[:cart]) 
  end
  
  def destroy
    session[:cart] = nil
    flash[:notice] = "Your cart is currently empty"
    redirect_to :action => 'show'
  end
  
end
