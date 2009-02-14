require 'test_helper'

class CartControllerTest < ActionController::TestCase
  fixtures :products
  
  def setup
    @item = products(:one)
  end
  
  test "the cart page should successfully display if given any id" do
    post :show, :id => 1
    assert :success
    assert_template "show"
  end
  
  test "the cart should not show items if there are no items in cart" do
    #post :create, :controller => 'items', :cart_id => 1, :id => products(:one).id
    #assert_response :redirect
    post :show, :id => 1
    assert_tag :tag => 'table'
    assert_select "table" do
      assert_select "th", :count => 3 #3 column table
    end
    assert_select "h2", :count => 1, :text => /Your Golfap Books Cart/
    #assert_tag :tag => 'submit'
    
  end
  
  test "the cart should show items and prices and quantities if there are items in the cart" do
  
  end
  
  test "after emptying the cart, there should be no items left" do
  end
  
  test "adding a second copy of a book to the cart should increment the quantity by one" do
  end
  
  test "adding a second copy of a book to the cart should double the price" do
  end
  
  # def test_should_create_post
  #   assert_difference('Post.count') do
  #     post :create, :post => { :title => 'Hi', :body => 'This is my first post.'}
  #   end
  #   assert_redirected_to post_path(assigns(:post))
  #   assert_equal 'Post was successfully created.', flash[:notice]
  # end
  
end
