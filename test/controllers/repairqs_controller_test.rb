require 'test_helper'

class RepairqsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repairq = repairqs(:one)
  end

  test "should get index" do
    get repairqs_url
    assert_response :success
  end

  test "should get new" do
    get new_repairq_url
    assert_response :success
  end

  test "should create repairq" do
    assert_difference('Repairq.count') do
      post repairqs_url, params: { repairq: { default_login: @repairq.default_login, default_pin: @repairq.default_pin, location: @repairq.location, name: @repairq.name, server: @repairq.server } }
    end

    assert_redirected_to repairq_url(Repairq.last)
  end

  test "should show repairq" do
    get repairq_url(@repairq)
    assert_response :success
  end

  test "should get edit" do
    get edit_repairq_url(@repairq)
    assert_response :success
  end

  test "should update repairq" do
    patch repairq_url(@repairq), params: { repairq: { default_login: @repairq.default_login, default_pin: @repairq.default_pin, location: @repairq.location, name: @repairq.name, server: @repairq.server } }
    assert_redirected_to repairq_url(@repairq)
  end

  test "should destroy repairq" do
    assert_difference('Repairq.count', -1) do
      delete repairq_url(@repairq)
    end

    assert_redirected_to repairqs_url
  end
end
