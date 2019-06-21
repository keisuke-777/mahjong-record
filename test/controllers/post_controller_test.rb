require 'test_helper'

class PostControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get post_edit_url
    assert_response :success
  end

end
