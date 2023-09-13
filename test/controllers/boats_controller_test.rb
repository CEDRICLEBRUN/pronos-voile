require "test_helper"

class BoatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get boat_index_url
    assert_response :success
  end

  test "should get show" do
    get boat_show_url
    assert_response :success
  end
end
