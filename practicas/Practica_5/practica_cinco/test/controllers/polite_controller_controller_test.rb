require 'test_helper'

class PoliteControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get salute" do
    get polite_controller_salute_url
    assert_response :success
  end

end
