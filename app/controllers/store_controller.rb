
class StoreController < ApplicationController
  before_filter :find_cart, :except => :empty_cart
  
  def index
    #find_cart
    @cart = find_cart 
    @products = Product.find_products_for_sale
    @cart_id = 1 # for now, no users
  end
  
  def checkout
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Your cart is empty")
    else
      @order = Order.new
    end
  end
  
  def save_order
    @cart = find_cart
    @order = Order.new(params[:order]) 
    @order.add_line_items_from_cart(@cart) 
    if @order.save                     
      session[:cart] = nil
      redirect_to_index(I18n.t('flash.thanks'))
    else
      render :action => 'checkout'
    end
  end
  
  
  private
    def find_cart
      session[:cart] ||= Cart.new
    end
    
    def redirect_to_index(msg = nil)
      flash[:notice] = msg if msg
      redirect_to :action => 'index'
    end
    
  protected
    def authorize
    end

  
end
