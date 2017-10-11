require 'test_helper'

class GroupMeBotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_me_bot = group_me_bots(:one)
  end

  test "should get index" do
    get group_me_bots_url
    assert_response :success
  end

  test "should get new" do
    get new_group_me_bot_url
    assert_response :success
  end

  test "should create group_me_bot" do
    assert_difference('GroupMeBot.count') do
      post group_me_bots_url, params: { group_me_bot: { bot_id: @group_me_bot.bot_id, name: @group_me_bot.name, token: @group_me_bot.token } }
    end

    assert_redirected_to group_me_bot_url(GroupMeBot.last)
  end

  test "should show group_me_bot" do
    get group_me_bot_url(@group_me_bot)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_me_bot_url(@group_me_bot)
    assert_response :success
  end

  test "should update group_me_bot" do
    patch group_me_bot_url(@group_me_bot), params: { group_me_bot: { bot_id: @group_me_bot.bot_id, name: @group_me_bot.name, token: @group_me_bot.token } }
    assert_redirected_to group_me_bot_url(@group_me_bot)
  end

  test "should destroy group_me_bot" do
    assert_difference('GroupMeBot.count', -1) do
      delete group_me_bot_url(@group_me_bot)
    end

    assert_redirected_to group_me_bots_url
  end
end
