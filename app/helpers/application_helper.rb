# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def pennies_to_dollars price_in_pennies
    price_in_dollars = price_in_pennies/100.00
    sprintf("$%0.02f", price_in_dollars) 
  end
  
end
