require 'test_helper'

class CouponControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get coupon_create_url
    assert_response :success
  end

end
