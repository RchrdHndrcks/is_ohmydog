require "test_helper"

class NewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get news_index_url
    assert_response :success
  end

  test "should get show" do
    get news_show_url
    assert_response :success
  end

  test "should get create" do
    get news_create_url
    assert_response :success
  end
end
