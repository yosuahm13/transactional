require "test_helper"

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save" do
    team = Team.new
    assert_not team.save
  end

  test "should save" do
    team = Team.new
    team.name = "BBCA"
    assert team.save
  end
end
