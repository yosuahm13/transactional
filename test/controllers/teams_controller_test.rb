require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teams_path
    assert_response :success
  end

  test "should get new" do
    get new_team_path
    assert_response :success
  end

  test "should get balance" do
    team = Team.create(name: "Test")
    get balance_team_path(:id => team.id)
    assert_response :success
  end

  test "should get transactions" do
    team = Team.create(name: "Test")
    get transactions_team_path(:id => team.id)
    assert_response :success
  end
end
