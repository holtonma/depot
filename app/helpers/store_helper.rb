module StoreHelper
  
  def did_you_quit_your_job? name
    name = "Aaron" ? "Yes" : "No"
  end
  

  def hidden_div_if(condition, attributes = {}, &block) 
    if condition 
      attributes["style"] = "display: none" 
    end 
    content_tag("div", attributes, &block) 
  end 

  
  
end
