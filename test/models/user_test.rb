require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save" do
    user = User.new
    assert_not user.save
  end

  test "should save" do
    user = User.new
    user.name = "John"
    assert user.save
  end
end
