require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, :line_item => { }
    end

    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should show line_item" do
    get :show, :id => line_items(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => line_items(:one).id
    assert_response :success
  end

  test "should update line_item" do
    put :update, :id => line_items(:one).id, :line_item => { }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, :id => line_items(:one).id
    end

    assert_redirected_to line_items_path
  end
end
