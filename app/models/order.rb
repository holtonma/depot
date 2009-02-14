class Order < ActiveRecord::Base
  has_many :line_items
  
  PAYMENT_TYPES = [ 
    # Displayed stored in db 
    [ "Check", "check" ], 
    [ "Credit card", "cc" ], 
    [ "Purchase order", "po" ] 
  ]
end
