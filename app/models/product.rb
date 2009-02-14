class Product < ActiveRecord::Base
  
  #has_many :orders, :through => :line_items 
  has_many :items
  
  def self.find_products_for_sale
    Product.find(:all, :order => "title")
  end
  
  validates_presence_of :title, :price, :description, :image_url 
  validates_uniqueness_of :title
  validates_numericality_of :price, :greater_than_or_equal_to => 1
  validates_format_of :image_url, 
    :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
end
