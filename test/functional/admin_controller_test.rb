require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  # Dear AdminController "the time for honoring yourself will soon be at an end" -Maximus
  def setup
    @request.session[:user_id] = nil #not logged in yet
  end
  
  test "the login should appear with two fields" do
    get :login
    assert :ok
    assert_template 'login'
    assert_select "input#name", :text => "", :count => 1
    assert_select "input#password", :text => "", :count => 1
    assert_select "input[name=commit]", :count => 1
  end
  
  test "the logout should wipe out the session" do
    @request.session[:user_id] = users(:one).id
    get :logout
    assert :ok
    assert_equal nil, @request.session[:user_id]
    assert_redirected_to 'login'
  end
  
  test "index when a valid admin user is logged in" do
    @request.session[:user_id] = users(:one).id
    get :index
    assert :ok
    assert_template 'index'
    assert_select "h1", :text => 'Welcome'
    #for a logged in user, the side bar should have links for Products, Users, Orders
    assert_select "div#side" do 
      assert_select "ul#admin_list" do
        assert_select "a", :count => 4
        assert_select "a", :text => 'Orders'
        assert_select "a", :text => 'Products'
        assert_select "a", :text => 'Users'
        assert_select "a", :text => 'Logout'
      end
    end 
    
    
  end
  
end
