require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  
  # test "add_to_cart adds a product to the cart" do
  #   # moved into items_controller_test -- 'posting to cart_items adds a product to the cart'
  # end
  
  test "session contains cart" do
    get :index
    assert session[:cart]
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
    assert_not_nil assigns(:products).size 
    assert_not_nil assigns(:products)
    assert_template "index"

    Product.find_products_for_sale.each do |product|
      assert_tag :tag => 'h3', :content => product.title
      assert_match /#{sprintf("%01.2f", product.price / 100.00)}/, @response.body
    end
  end
  
  test "should have as many product image tags as products" do
    get :index
    img_count = css_select("div.entry > img").size 
    assert_select "div.entry > img", :count => img_count
  end
  
  test "each product entry should have a price" do
    get :index
    assert_select "div.price-line", :child => /<span class="price">\$\d<\/span>/
    css_select("div.price-line > span.price").each do |price_markup|
      assert_tag :tag => "span", :attributes => { :class => "price" } 
    end
  end
  
  test "store/checkout should present checkout order form if cart has one item" do
    @request.session[:cart] = Cart.new
    @request.session[:cart].add_product(products(:one))
    post :checkout
    assert_response :success
    assert_template "checkout"
    assert_select 'input#order_name'
    assert_select 'textarea#order_address'
    assert_select 'input#order_email'
    assert_select 'select#order_pay_type'
    
  end
  
  test "a valid checkout should create an order" do
    #assert_difference('Order.count') do
      post :save_order, :post => { :name => 'yoyoma', :address => 'foo bar lane', :email => "haiworld@foobar.com", :pay_type => "cc"}
    #end
    assert_response :ok
    #assert_redirected_to '/store/save_order' #save_order_path(assigns(:post))
    assert_equal 'Thank you for your order', flash[:notice]
  end
    
end
