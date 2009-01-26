class Product < ActiveRecord::Base
  
  def self.find_products_for_sale
    Product.find(:all, :order => "title")
  end
  
  validates_presence_of :title, :price #:price?
  
  
end
