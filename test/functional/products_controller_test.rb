require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = users(:one).id
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products).size 
    assert_not_nil assigns(:products)
    assert_template "index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[title]'
    }
    assert_tag :tag => 'textarea', :attributes => {
      :name => 'product[description]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[image_url]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[price]'
    }
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, :product => {
        :title        => 'awesome product',
        :description  => 'awesome product description',
        :image_url    => 'http://example.com/foo.gif',
        :price        => '100'
      }
    end

    assert_redirected_to product_path(assigns(:product))
  end
  
  test "should spit out error messages on screen because of a missing title" do
    post :create, :product => {
      :title        => '',
      :description  => 'golfap rules the tubes',
      :image_url    => 'http://example.com/foo.gif',
      :price        => '1000'
    }
    assert_template "new"
    assert_tag :tag => "div", :attributes => { :id => "errorExplanation" }
    assert_tag :tag => "div", :attributes => { :class => "fieldWithErrors"}
    assert_select "div[class*=fieldWithErrors]", :count => 2
    assert_select "div[class*=errorExplanation]", :count => 1
    # check explicitly that both the input is blank for Title and it is a fieldWithErrors
    assert_select "div.fieldWithErrors" do 
      assert_select "input:last-of-type", ""
    end
    # check explicitly that both the input#product_price errs out and is blank
    assert_equal 1, css_select("div.fieldWithErrors > input#product_title").size 
    assert_select "div.fieldWithErrors > input#product_title", :text => ""
  end
  
  test "should spit out error messages on screen because of a missing price" do
    post :create, :product => {
      :title        => 'A Long Walk Spoiled',
      :description  => 'golfap rules the tubes',
      :image_url    => 'http://example.com/foo.gif',
      :price        => ''
    }
    assert_template "new"
    assert_tag :tag => "div", :attributes => { :id => "errorExplanation" }
    assert_tag :tag => "div", :attributes => { :class => "fieldWithErrors"}
    assert_select "div[class*=fieldWithErrors]", :count => 2
    assert_select "div[class*=errorExplanation]", :count => 1
    assert_select "div.fieldWithErrors" do 
      assert_select "input:last-of-type", ""
    end
    # check explicitly that both the input#product_price errs out and is blank
    assert_equal 1, css_select("div.fieldWithErrors > input#product_price").size 
    assert_select "div.fieldWithErrors > input#product_price", :text => ""
  end
  
  test "should spit out error messages on screen because of a missing description" do
    post :create, :product => {
      :title        => 'A Long Walk Spoiled',
      :description  => '',
      :image_url    => 'http://example.com/foo.gif',
      :price        => '2345'
    }
    assert_template "new"
    assert_tag :tag => "div", :attributes => { :id => "errorExplanation" }
    assert_tag :tag => "div", :attributes => { :class => "fieldWithErrors"}
    assert_select "div[class*=fieldWithErrors]", :count => 2
    assert_select "div[class*=errorExplanation]", :count => 1
    # check explicitly that both the input#product_price errs out and is blank
    assert_equal 1, css_select("div.fieldWithErrors > textarea#product_description").size 
    assert_select "div.fieldWithErrors > textarea#product_description", :text => ""
  end
  
  test "should spit out error messages on screen because of a missing image_url" do
    post :create, :product => {
      :title        => 'A Long Walk Spoiled',
      :description  => 'golfap rules the tubes',
      :image_url    => '',
      :price        => '2345'
    }
    assert_template "new"
    assert_tag :tag => "div", :attributes => { :id => "errorExplanation" }
    assert_tag :tag => "div", :attributes => { :class => "fieldWithErrors"}
    assert_select "div[class*=fieldWithErrors]", :count => 2
    assert_select "div[class*=errorExplanation]", :count => 1
    # check explicitly that both the input#product_price errs out and is blank
    assert_equal 1, css_select("div.fieldWithErrors > input#product_image_url").size 
    assert_select "div.fieldWithErrors > input#product_image_url", :text => ""
  end

  test "should show product" do
    get :show, :id => products(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => products(:one).id
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[title]'
    }
    assert_tag :tag => 'textarea', :attributes => {
      :name => 'product[description]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[image_url]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'product[price]'
    }
    assert_response :success
  end

  test "should update product" do
    put :update, :id => products(:one).id, :product => {
      :title => 'mega awesome title'
    }
    assert_redirected_to product_path(assigns(:product))

    assert_equal 'mega awesome title', Product.find(products(:one).id).title
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, :id => products(:one).id
    end

    assert_redirected_to products_path
  end
end
