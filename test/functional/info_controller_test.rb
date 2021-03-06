require 'test_helper'
require 'nokogiri'

class InfoControllerTest < ActionController::TestCase
  
  test "who_bought can return XML with proper data content and defined hierarchy" do
    get :who_bought, :id => products(:one).id, :format => 'xml'
    
    assert_response :success
    
    #data content
    assert_match /<title>Golf My Way<\/title>/, @response.body
    assert_match /<email>holtonma@gmail.com<\/email>/, @response.body
    assert_match /<address>335 Nora Ave/, @response.body
    assert_match /<id type="integer">953125641<\/id>/, @response.body
    assert_match /<image-url>http:\/\/golfap.com\/books<\/image-url>/, @response.body
    assert_match /<price type="integer">2324<\/price>/, @response.body
    assert_match /<pay-type>cc<\/pay-type>/, @response.body
    
    #xml hierarchy
    doc = Nokogiri::XML(@response.body)
    assert_equal 1, doc.xpath('/product').length
    #assert_equal 1, doc.xpath('/order').length
      assert_equal 1, doc.xpath('/product[created-at]').length
      assert_equal 1, doc.xpath('/product[description]').length
      assert_equal 1, doc.xpath('/product[id]').length
      assert_equal 1, doc.xpath('/product[image-url]').length
      assert_equal 1, doc.xpath('/product[price]').length
      assert_equal 1, doc.xpath('/product[orders]').length
      assert_equal 1, doc.xpath('/product[title]').length
      assert_equal 1, doc.xpath('/product[orders]').length
        assert_equal 1, doc.xpath('/product[orders]//order').length
          assert_equal 1, doc.xpath('/product[orders]//order[address]').length
          assert_equal 1, doc.xpath('/product[orders]//order[created-at]').length
          assert_equal 1, doc.xpath('/product[orders]//order[email]').length
          assert_equal 1, doc.xpath('/product[orders]//order[id]').length
          assert_equal 1, doc.xpath('/product[orders]//order[name]').length
          assert_equal 1, doc.xpath('/product[orders]//order[pay-type]').length
        
    # <?xml version=\"1.0\" encoding=\"UTF-8\"?>\n
    # <product>\n  
    #   <created-at type=\"datetime\">2009-02-23T00:13:51Z</created-at>\n  
    #   <description>by Jack Nicklaus</description>\n  
    #   <id type=\"integer\">953125641</id>\n  
    #   <image-url>http://golfap.com/books</image-url>\n  
    #   <price type=\"integer\">2324</price>\n  
    #   <title>Golf My Way</title>\n  
    #   <updated-at type=\"datetime\">2009-02-23T00:13:51Z</updated-at>\n  
    #   <orders type=\"array\">\n    
    #     <order>\n      
    #       <address>335 Nora Ave</address>\n      
    #       <created-at type=\"datetime\">2009-02-23T00:13:51Z</created-at>\n      
    #       <email>holtonma@gmail.com</email>\n      
    #       <id type=\"integer\">953125641</id>\n      
    #       <name>Holton</name>\n      
    #       <pay-type>cc</pay-type>\n      
    #       <updated-at type=\"datetime\">2009-02-23T00:13:51Z</updated-at>\n    
    #     </order>\n  
    #   </orders>\n
    # </product>
  end
  
  test "who_bought can return JSON with proper data and hierarchy" do
    get :who_bought, :id => products(:one).id, :format => 'json'
    assert :success
    doc = ActiveSupport::JSON.decode(@response.body)
    assert doc['product']
    assert_equal assigns(:product)[:description], doc['product']['description']
    assert_equal assigns(:product)[:price], doc['product']['price']
    assert_equal assigns(:product)[:title], doc['product']['title']
    assert_equal 1, assigns(:orders).length
    assert_equal assigns(:orders).first[:id], doc['product']['orders'].first['id']
    assert_equal assigns(:orders).first[:pay_type], doc['product']['orders'].first['pay_type']
    assert_equal assigns(:orders).first[:address], doc['product']['orders'].first['address']
    assert_equal assigns(:orders).first[:email], doc['product']['orders'].first['email']
    # 
    # <{"image_url"=>"http://golfap.com/books",
    #      "updated_at"=>Mon Feb 23 01:05:14 UTC 2009,
    #      "price"=>2324,
    #      "title"=>"Golf My Way",
    #      "orders"=>
    #       [{"name"=>"Holton",
    #         "updated_at"=>Mon Feb 23 01:05:14 UTC 2009,
    #         "id"=>953125641,
    #         "pay_type"=>"cc",
    #         "address"=>"335 Nora Ave",
    #         "created_at"=>Mon Feb 23 01:05:14 UTC 2009,
    #         "email"=>"holtonma@gmail.com"}],
    #      "id"=>953125641,
    #      "description"=>"by Jack Nicklaus",
    #      "created_at"=>Mon Feb 23 01:05:14 UTC 2009}>
     
  end
  
  test "testing that .atom format does something useful" do
    get :who_bought, :id => products(:one).id, :format => "atom"
    assert_response :success
    
    doc = Nokogiri::XML(@response.body)
    
    #puts doc.xpath('feed[:id]')
    #puts doc.xpath('/feed[:id]')
    assert_match /<title>Who bought #{assigns(:product)[:title]}<\/title>/, @response.body
    assert_match /#{assigns(:product)[:email]}/, @response.body
    assert_match /<title>Order #{assigns(:orders).first[:id]}<\/title>/, @response.body
    
    #assert_select "div.price-line", :child => /<span class="price">\$\d<\/span>/
    css_select("feed > entry").each do |el|
      assert_tag :tag => "id"
      assert_tag :tag => "published"
      assert_tag :tag => "link", :attributes => { :rel => "alternate" } 
      assert_tag :tag => "summary"
    end
    
    assert_select "title", :count => 2
    assert_select "published", :count => 1
    assert_select "updated", :count => 2
    assert_select "summary", :count => 1
    assert_select "name", :count => 1
    assert_select "email", :count => 1
    
    assert_select("table").each do |tr|
      assert_select "th", :count => 5
      assert_select "tr", :count => 3
      assert_select "td", :count => 3
    end
    
    assert_select("author").each do |el|
      assert_select "name", :count => 1
      assert_select "email", :count => 1
    end
    
    
    #puts @response.body
    #assert_equal 1, doc.xpath('/product').length
    # <?xml version="1.0" encoding="UTF-8"?>
    #     <feed xmlns="http://www.w3.org/2005/Atom" xml:lang="en-US">
    #       <id>tag:test.host,2005:/info/who_bought/953125641</id>
    #       <link rel="alternate" type="text/html" href="http://test.host"/>
    #       <link rel="self" type="application/atom+xml" href="http://test.host/info/who_bought/953125641.atom"/>
    #       <title>Who bought Golf My Way</title>
    #       <updated>2009-02-23T01:48:51Z</updated>
    #       <entry>
    #         <id>tag:test.host,2005:Order/953125641</id>
    #         <published>2009-02-23T01:48:51Z</published>
    #         <updated>2009-02-23T01:48:51Z</updated>
    #         <link rel="alternate" type="text/html" href="http://test.host/orders/953125641"/>
    #         <title>Order 953125641</title>
    #         <summary type="xhtml">
    #           <div xmlns="http://www.w3.org/1999/xhtml">
    #             <p>Shipped to 335 Nora Ave</p>
    #             <table>
    #               <tr>
    #                 <th>Product</th>
    #                 <th>Quantity</th>
    #                 <th>Total Price</th>
    #               </tr>
    #               <tr>
    #                 <td>Golf My Way</td>
    #                 <td>1</td>
    #                 <td>$45.67</td>
    #               </tr>
    #               <tr>
    #                 <th colspan="2">total</th>
    #                 <th>$45.67</th>
    #               </tr>
    #             </table>
    #             <p>Paid by cc</p>
    #           </div>
    #         </summary>
    #         <author>
    #           <name>Holton</name>
    #           <email>holtonma@gmail.com</email>
    #         </author>
    #       </entry>
    #     </feed>
  end
  
  
  test "html ho hum boring renders html with list and links" do
    get :who_bought, :id => products(:one).id

    assert_select "div#main" do
      assert_select "ul" do
        assert_select "li" do
          assert_select "a", "Holton"
        end
      end
    end
  end
  
end
