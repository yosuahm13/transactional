require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should get balance" do
    get balance_user_path(:id => users(:one).id)
    assert_response :success
  end

  test "should get transactions" do
    get transactions_user_path(:id => users(:one).id)
    assert_response :success
  end
end
