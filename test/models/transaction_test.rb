require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save" do
    transaction = Transaction.new
    assert_not transaction.save

    transaction.source_id = users(:one).id
    assert_not transaction.save

    transaction.target_id = stocks(:one).id
    assert_not transaction.save

    transaction.transaction_types_id = transaction_types(:transfer).id
    assert_not transaction.save

    transaction.value = 0
    assert_not transaction.save
  end

  test "should save" do
    transaction = Transaction.new

    transaction.source_id = users(:one).id
    transaction.target_id = stocks(:one).id
    transaction.transaction_types_id = transaction_types(:transfer).id
    transaction.value = 100

    assert transaction.save
  end

  test "should not save decimal" do
    transaction = Transaction.new

    transaction.source_id = users(:one).id
    transaction.target_id = stocks(:one).id
    transaction.transaction_types_id = transaction_types(:transfer).id
    transaction.value = 100.9
    
    assert_not transaction.save
  end
end
