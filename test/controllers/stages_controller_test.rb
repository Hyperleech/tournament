require 'test_helper'

class StagesControllerTest < ActionDispatch::IntegrationTest
  test "should get auto_generate" do
    get stages_auto_generate_url
    assert_response :success
  end

end
