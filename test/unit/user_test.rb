
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "Can authenticate myself" do
    assert User.authenticate('holtonma', 'daemon')  
  end
  
  
end
