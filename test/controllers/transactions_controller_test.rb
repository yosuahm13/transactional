require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get transactions_path
    assert_response :success
  end

  test "should get new" do
    get transaction_new_path(:wallet_id => users(:one).id, :type_id => transaction_types(:deposit).id)
    assert_response :success
  end

  test "should create deposit" do
    post transaction_create_path(:wallet_id => users(:one).id, :type_id => transaction_types(:deposit).id), 
      params: { transaction: { transaction_types_id: transaction_types(:deposit).id, value: 10}}

    assert_redirected_to transactions_user_path(:id => users(:one).id)
    assert_equal "Transaction has been saved.", flash[:notice]
  end

  test "should create withdraw" do
    t = Transaction.create(:transaction_types_id => transaction_types(:deposit).id, :value => 10, :target_id => users(:one).id, :source_id => 1)
    post transaction_create_path(:wallet_id => users(:one).id, :type_id => transaction_types(:deposit).id), 
      params: { transaction: { transaction_types_id: transaction_types(:withdraw).id, value: 10}}

    assert_redirected_to transactions_user_path(:id => users(:one).id)
    assert_equal "Transaction has been saved.", flash[:notice]
  end

  test "should not create withdraw" do
    post transaction_create_path(:wallet_id => users(:one).id, :type_id => transaction_types(:deposit).id), 
      params: { transaction: { transaction_types_id: transaction_types(:withdraw).id, value: 10}}

    assert_response :success
    assert_equal "Insufficient balance. Failed to save transaction.", flash[:alert]
  end

  test "should not create withdraw with decimal value" do
    t = Transaction.create(:transaction_types_id => transaction_types(:deposit).id, :value => 10, :target_id => users(:one).id, :source_id => 1)
    post transaction_create_path(:wallet_id => users(:one).id, :type_id => transaction_types(:deposit).id), 
      params: { transaction: { transaction_types_id: transaction_types(:withdraw).id, value: 1.5}}

    assert_response :success
    assert_equal "Failed to save transaction. Validation failed: Value must be an integer", flash[:alert]
  end  

  test "should create transfer" do
    t = Transaction.create(:transaction_types_id => transaction_types(:deposit).id, :value => 10, :target_id => users(:one).id, :source_id => 1)
    post transaction_create_path(:wallet_id => users(:one).id, :type_id => transaction_types(:transfer).id), 
      params: { transaction: { transaction_types_id: transaction_types(:transfer).id, value: 10, target_id: stocks(:one).id}}

    assert_redirected_to transactions_user_path(:id => users(:one).id)
    assert_equal "Transaction has been saved.", flash[:notice]
  end

  test "should not create transfer" do
    t = Transaction.create(:transaction_types_id => transaction_types(:deposit).id, :value => 10, :target_id => users(:one).id, :source_id => 1)
    post transaction_create_path(:wallet_id => users(:one).id, :type_id => transaction_types(:transfer).id), 
      params: { transaction: { transaction_types_id: transaction_types(:transfer).id, value: 10}}

    assert_response :success
    assert_equal "Failed to save transaction. Validation failed: Target must exist, Target can't be blank", flash[:alert]
  end

  test "should not create transfer with decimal value" do
    t = Transaction.create(:transaction_types_id => transaction_types(:deposit).id, :value => 10, :target_id => users(:one).id, :source_id => 1)
    post transaction_create_path(:wallet_id => users(:one).id, :type_id => transaction_types(:transfer).id), 
      params: { transaction: { transaction_types_id: transaction_types(:transfer).id, value: 5.5, target_id: stocks(:one).id}}

    assert_response :success
    assert_equal "Failed to save transaction. Validation failed: Value must be an integer", flash[:alert]
  end

  test "should not create transfer with zero value" do
    t = Transaction.create(:transaction_types_id => transaction_types(:deposit).id, :value => 10, :target_id => users(:one).id, :source_id => 1)
    post transaction_create_path(:wallet_id => users(:one).id, :type_id => transaction_types(:transfer).id), 
      params: { transaction: { transaction_types_id: transaction_types(:transfer).id, value: 0, target_id: stocks(:one).id}}

    assert_response :success
    assert_equal "Failed to save transaction. Validation failed: Value must be greater than 0", flash[:alert]
  end
end
