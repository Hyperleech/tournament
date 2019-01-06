require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get Edit" do
    get games_Edit_url
    assert_response :success
  end

end
