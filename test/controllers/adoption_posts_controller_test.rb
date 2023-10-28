require "test_helper"

class AdoptionPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get adoption_posts_index_url
    assert_response :success
  end
end
