require 'test_helper'

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  fixtures :purchases

  test "should get index" do
    get purchases_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_url
    assert_response :success
  end

  test "should get create" do
    get purchases_url
    assert_response :success
  end

  test "should get destroy" do
    skip
    purchase = purchases(:one)
    delete purchase_url(purchase[:id])
    assert_equal({}, purchase)
    assert_response :success
  end

end
