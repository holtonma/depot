include StoreUtil

class CartController < ApplicationController
  layout "store"
   
  def show
    # cart()  ... get /cart/:id  # grab and display contents of the cart
    @cart = StoreUtil.find_cart(session[:cart]) 
  end
  
  def destroy
    session[:cart] = nil
    flash[:notice] = "Your cart is currently empty"
    redirect_to :controller => 'store', :action => 'index' #'show'
  end

  protected
    def authorize
    end
  
end
