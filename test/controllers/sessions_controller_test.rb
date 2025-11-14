require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sessions_new_url
    assert_response :success
  end

  test "should get show" do
    get sessions_show_url
    assert_response :success
  end

  test "should get prompt" do
    get sessions_prompt_url
    assert_response :success
  end

  test "should get next_question" do
    get sessions_next_question_url
    assert_response :success
  end

  test "should get save_reflection" do
    get sessions_save_reflection_url
    assert_response :success
  end

  test "should get constellation" do
    get sessions_constellation_url
    assert_response :success
  end

  test "should get complete" do
    get sessions_complete_url
    assert_response :success
  end
end
