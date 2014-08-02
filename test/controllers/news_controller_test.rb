require 'test_helper'

class NewsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get tag" do
    get :tag
    assert_response :success
  end

  test "should get city" do
    get :city
    assert_response :success
  end

end
