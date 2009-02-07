#require 'store_util.rb'
include StoreUtil

class ItemsController < ApplicationController
  
  def new
    #new_cart_item()
  end
  
  def create
    # add item(product) to cart
    product = Product.find(params[:id])
    @cart = StoreUtil.find_cart(session[:cart]) 
    @cart.add_product(product)
    
    redirect_to url_for :controller => 'cart', :action => 'show', :id => params[:cart_id]
  end
  
  def index
  end
  
  def update
  end
  
end
