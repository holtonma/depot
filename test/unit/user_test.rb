
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "Can authenticate myself" do
    assert User.authenticate('holtonma', 'daemon')  
  end
  
  test "can't delete last user" do
    users = User.find(:all)
    assert_raise(RuntimeError) do
      loop do
        users.first.destroy
        users.shift
      end
    end

    assert_equal 1, users.length
  end
    
end
