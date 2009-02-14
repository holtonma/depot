include StoreUtil

class ItemsController < ApplicationController
    
  def create
    # add item(product) to cart
    product = Product.find(params[:id])
    @cart = StoreUtil.find_cart(session[:cart]) 
    @cart.add_product(product)
    
    redirect_to url_for :controller => 'store', :action => 'index' #, :id => params[:cart_id]
  end
  
  def index
    #alias for cart#show ?
    #redirect_to :action => 'show', :controller => 'cart'
  end
  
end
