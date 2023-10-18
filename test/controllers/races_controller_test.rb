require "test_helper"

class RacesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get races_show_url
    assert_response :success
  end
end
