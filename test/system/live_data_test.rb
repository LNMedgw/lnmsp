require "application_system_test_case"

class LiveDataTest < ApplicationSystemTestCase
  setup do
    @live_datum = live_data(:one)
  end

  test "visiting the index" do
    visit live_data_url
    assert_selector "h1", text: "Live Data"
  end

  test "creating a Live datum" do
    visit live_data_url
    click_on "New Live Datum"

    fill_in "Liveurl", with: @live_datum.liveurl
    fill_in "Streamstart", with: @live_datum.streamstart
    fill_in "Thumbnailurl", with: @live_datum.thumbnailurl
    fill_in "Username", with: @live_datum.username
    click_on "Create Live datum"

    assert_text "Live datum was successfully created"
    click_on "Back"
  end

  test "updating a Live datum" do
    visit live_data_url
    click_on "Edit", match: :first

    fill_in "Liveurl", with: @live_datum.liveurl
    fill_in "Streamstart", with: @live_datum.streamstart
    fill_in "Thumbnailurl", with: @live_datum.thumbnailurl
    fill_in "Username", with: @live_datum.username
    click_on "Update Live datum"

    assert_text "Live datum was successfully updated"
    click_on "Back"
  end

  test "destroying a Live datum" do
    visit live_data_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Live datum was successfully destroyed"
  end
end
