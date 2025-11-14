require "test_helper"

class GalaxiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get galaxies_index_url
    assert_response :success
  end

  test "should get select" do
    get galaxies_select_url
    assert_response :success
  end

  test "should get random" do
    get galaxies_random_url
    assert_response :success
  end
end
