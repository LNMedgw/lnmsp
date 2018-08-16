require 'test_helper'

class LiveDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @live_datum = live_data(:one)
  end

  test "should get index" do
    get live_data_url
    assert_response :success
  end

  test "should get new" do
    get new_live_datum_url
    assert_response :success
  end

  test "should create live_datum" do
    assert_difference('LiveDatum.count') do
      post live_data_url, params: { live_datum: { liveurl: @live_datum.liveurl, streamstart: @live_datum.streamstart, thumbnailurl: @live_datum.thumbnailurl, username: @live_datum.username } }
    end

    assert_redirected_to live_datum_url(LiveDatum.last)
  end

  test "should show live_datum" do
    get live_datum_url(@live_datum)
    assert_response :success
  end

  test "should get edit" do
    get edit_live_datum_url(@live_datum)
    assert_response :success
  end

  test "should update live_datum" do
    patch live_datum_url(@live_datum), params: { live_datum: { liveurl: @live_datum.liveurl, streamstart: @live_datum.streamstart, thumbnailurl: @live_datum.thumbnailurl, username: @live_datum.username } }
    assert_redirected_to live_datum_url(@live_datum)
  end

  test "should destroy live_datum" do
    assert_difference('LiveDatum.count', -1) do
      delete live_datum_url(@live_datum)
    end

    assert_redirected_to live_data_url
  end
end
