require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = users(:one).id
  end
 
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
 
  test "should get new" do
    get :new
    assert_response :success
  end
 
  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {
        :name                   => 'aksdljfhalksdjfh',
        :password               => 'onetwo',
        :password_confirmation  => 'onetwo',
      }
    end
 
    assert_redirected_to users_path
  end
  
  test "should not create user and show red box when name is blank" do
    assert_no_difference('User.count') do
      post :create, :user => {
        :name                   => '',
        :password               => 'onetwo',
        :password_confirmation  => 'onetwo',
      }
    end
    
    assert_response :ok
    assert_tag :tag => "div", :attributes => { :id => "errorExplanation" }
    assert_tag :tag => "div", :attributes => { :class => "fieldWithErrors"}
    assert_select "div[class*=fieldWithErrors]", :count => 2
    assert_select "div[class*=errorExplanation]", :count => 1
    # check explicitly that both the input is blank for Title and it is a fieldWithErrors
    assert_select "div.fieldWithErrors" do 
      assert_select "input:last-of-type", ""
    end
    # check explicitly that both the input#product_price errs out and is blank
    assert_equal 1, css_select("div.fieldWithErrors > input#user_name").size 
    assert_select "div.fieldWithErrors > input#user_name", :text => ""
  end
  
  test "should not create user and show red box when password is blank" do
    assert_no_difference('User.count') do
      post :create, :user => {
        :name                   => 'asdfasdfasdf',
        :password               => '',
        :password_confirmation  => 'onetwo',
      }
    end
    
    assert_response :ok
    assert_tag :tag => "div", :attributes => { :id => "errorExplanation" }
    assert_tag :tag => "div", :attributes => { :class => "fieldWithErrors"}
    assert_select "div[class*=fieldWithErrors]", :count => 1
    assert_select "div[class*=errorExplanation]", :count => 1
    # check explicitly that both the input is blank for Title and it is a fieldWithErrors
    assert_select "div.fieldWithErrors" do 
      assert_select "input:last-of-type", ""
    end
    # check explicitly that both the input#product_price errs out and is blank
    assert_equal 1, css_select("div.fieldWithErrors > input#user_password").size 
    assert_select "div.fieldWithErrors > input#user_password", :text => ""
    assert_select "div#errorExplanation > ul > li", :text => "Password doesn't match confirmation"
    assert_select "div#errorExplanation > ul > li", :text => "Password Missing password"
    assert_select "div#errorExplanation > ul > li", :count => 2
  end
  
  test "should not create user and show red boxes when password does not match password confirm" do
    assert_no_difference('User.count') do
      post :create, :user => {
        :name                   => 'asdfasdfasdf',
        :password               => 'onetwotree',
        :password_confirmation  => 'onetwo',
      }
    end
    
    assert_response :ok
    assert_tag :tag => "div", :attributes => { :id => "errorExplanation" }
    assert_tag :tag => "div", :attributes => { :class => "fieldWithErrors"}
    assert_select "div[class*=fieldWithErrors]", :count => 1
    assert_select "div[class*=errorExplanation]", :count => 1
    # check explicitly that both the input is blank for Title and it is a fieldWithErrors
    assert_select "div.fieldWithErrors" do 
      assert_select "input:last-of-type", ""
    end
    # check explicitly that both the input#product_price errs out and is blank
    assert_equal 1, css_select("div.fieldWithErrors > input#user_password").size 
    assert_select "div.fieldWithErrors > input#user_password", :text => ""
    assert_select "div#errorExplanation > ul > li", :text => "Password doesn't match confirmation"
  end
    
  
  test "should show user" do
    get :show, :id => users(:one).id
    assert_response :success
  end
 
  test "should get edit" do
    get :edit, :id => users(:one).id
    assert_response :success
  end
 
  test "should update user" do
    put :update, :id => users(:one).id, :user => users(:one).attributes
    assert_redirected_to users_path
  end
 
  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).id
    end
 
    assert_redirected_to users_path
  end
  
  test "should direct to login when trying to go to users/index when not logged in" do
    @request.session[:user_id] = nil #not logged in yet
    get :index
    assert_redirected_to '/login'
  end
  
end
