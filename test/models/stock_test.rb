require "test_helper"

class StockTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save" do
    stock = Stock.new
    assert_not stock.save
  end

  test "should save" do
    stock = Stock.new
    stock.name = "BBCA"
    assert stock.save
  end
end
