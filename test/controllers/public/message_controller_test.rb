require "test_helper"

class Public::MessageControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get public_message_edit_url
    assert_response :success
  end
end
