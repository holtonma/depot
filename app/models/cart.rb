class Cart
  
  attr_reader :items
  
  def initialize
    @items = []
  end
  
  def add_product product
    current_item = @items.find { |it| it.product == product }
    if current_item
      current_item.increment_quantity
    else
      @items << Item.new(product)
    end
    
    #@items << product
  end
  
end
