require "test_helper"

class AdmissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admissions_create_url
    assert_response :success
  end

  test "should get accept" do
    get admissions_accept_url
    assert_response :success
  end

  test "should get reject" do
    get admissions_reject_url
    assert_response :success
  end
end
