require "test_helper"

class ModesControllerTest < ActionDispatch::IntegrationTest
  test "should get select" do
    get modes_select_url
    assert_response :success
  end
end
