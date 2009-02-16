require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = users(:one).id
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show order" do
    get :show, :id => orders(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => orders(:one).id
    assert_response :success
  end

  test "should update order" do
    put :update, :id => orders(:one).id, :order => { }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, :id => orders(:one).id
    end

    assert_redirected_to orders_path
  end
  
  test "should not create new order and show red boxes when order name does not exist" do
    assert_no_difference('Order.count') do
      post :create, :order => {
        :name     => '',
        :address  => '',
        :email    => '',
        :pay_type => ''
      }
    end
    
    assert_response :ok
    assert_tag :tag => "div", :attributes => { :id => "errorExplanation" }
    assert_tag :tag => "div", :attributes => { :class => "fieldWithErrors"}
    assert_select "div[class*=fieldWithErrors]", :count => 8 #labels and input elements
    assert_select "div[class*=errorExplanation]", :count => 1 
    # check explicitly that both the input is blank for Title and it is a fieldWithErrors
    assert_select "div.fieldWithErrors" do 
      assert_select "input:last-of-type", ""
    end
    # check explicitly that both the input#product_price errs out and is blank
    assert_equal 3, css_select("div.fieldWithErrors > input").size 
    assert_equal 1, css_select("div.fieldWithErrors > textarea").size 
    assert_select "div.fieldWithErrors > input#order_name", :text => ""
    assert_select "div.fieldWithErrors > textarea#order_address", :text => ""
    assert_select "div.fieldWithErrors > input#order_email", :text => ""
    assert_select "div.fieldWithErrors > input#order_pay_type", :text => ""
    assert_select "div#errorExplanation > ul > li", :text => "Name can't be blank"
    assert_select "div#errorExplanation > ul > li", :text => "Pay type can't be blank"
    assert_select "div#errorExplanation > ul > li", :text => "Pay type is not included in the list"
    assert_select "div#errorExplanation > ul > li", :text => "Address can't be blank"
    assert_select "div#errorExplanation > ul > li", :text => "Email can't be blank"
    assert_select "div#errorExplanation > ul > li", :count => 5 #labels and input elements
  end
end
