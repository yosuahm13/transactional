require "test_helper"

class TransactionTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "id should match" do
    assert_equal 1, transaction_types(:deposit).id
    assert_equal 2, transaction_types(:transfer).id
    assert_equal 3, transaction_types(:withdraw).id
  end
end
