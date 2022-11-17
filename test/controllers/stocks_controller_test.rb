require "test_helper"

class StocksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stocks_path
    assert_response :success
  end

  test "should get new" do
    get new_stock_path
    assert_response :success
  end

  test "should get balance" do
    get balance_stock_path(:id => stocks(:one).id)
    assert_response :success
  end

  test "should get transactions" do
    get transactions_stock_path(:id => stocks(:one).id)
    assert_response :success
  end
end
