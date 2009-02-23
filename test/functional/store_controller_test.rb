require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  
  LOCALES_DIRECTORY = "#{RAILS_ROOT}/config/locales"
  ESD = YAML.load_file("#{LOCALES_DIRECTORY}/es.yml")['es']
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
    #assert_equal 'Thank you for your order', flash[:notice]
  end
  
  test "locale stored in session" do
    get :index, :locale => "es"
    assert_response :success
    assert_equal "es", @response.session[:locale]
  end

  test "somehow a language selected that isn't supported" do
    get :index, :locale => "jp"
    assert_response :success
    assert_equal "en", @response.session[:locale]
    assert_equal "jp translation not available", @response.flash[:notice]
  end

  test "display sidebar links in Spanish when Spanish is selected" do
    get :index, :locale => "es"
    assert_response :success
    
    dictionary = ESD #YAML.load_file("#{LOCALES_DIRECTORY}/es.yml")['es'] #
    
    assert_match ESD['layout']['side']['home'], @response.body
    assert_match ESD['layout']['side']['questions'], @response.body
    assert_match ESD['layout']['side']['news'], @response.body
    assert_match ESD['layout']['side']['contact'], @response.body
    assert_match ESD['layout']['title'], @response.body
  end
  
  test "display cart in Spanish if there are items in the cart and Spanish is selected" do
    @request.session[:cart] = Cart.new
    @request.session[:cart].add_product(products(:one))
    get :checkout, :locale => "es"
    assert_response :success
    
    dictionary = ESD
        
    assert_match dictionary['checkout']['legend'], @response.body
    assert_match dictionary['checkout']['name'], @response.body
    assert_match dictionary['checkout']['address'], @response.body
    assert_match dictionary['checkout']['pay_type'], @response.body
    assert_match dictionary['checkout']['pay_prompt'], @response.body
    assert_match dictionary['checkout']['submit'], @response.body
    
   
  end
  
    
end
