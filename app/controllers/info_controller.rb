class InfoController < ApplicationController

  def who_bought
    @product = Product.find(params[:id])
    @orders  = @product.orders
    respond_to do |format|
      format.html
      format.xml { render :layout => false , 
              :xml => @product.to_xml(:include => :orders) } 
      format.json { render :layout => false , 
        :json => @product.to_json(:include => :orders) } 
      format.atom { render :layout => false }
    end
  end
  

protected

  def authorize
  end

end
