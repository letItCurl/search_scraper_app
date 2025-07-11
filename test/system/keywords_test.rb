require "application_system_test_case"

class KeywordsTest < ApplicationSystemTestCase
  setup do
    @keyword = keywords(:one)
  end

  test "visiting the index" do
    visit keywords_url
    assert_selector "h1", text: "Keywords"
  end

  test "should create keyword" do
    visit keywords_url
    click_on "New keyword"

    fill_in "Html cache", with: @keyword.html_cache
    fill_in "Name", with: @keyword.name
    fill_in "Total ads", with: @keyword.total_ads
    fill_in "Total links", with: @keyword.total_links
    fill_in "User", with: @keyword.user_id
    click_on "Create Keyword"

    assert_text "Keyword was successfully created"
    click_on "Back"
  end

  test "should update Keyword" do
    visit keyword_url(@keyword)
    click_on "Edit this keyword", match: :first

    fill_in "Html cache", with: @keyword.html_cache
    fill_in "Name", with: @keyword.name
    fill_in "Total ads", with: @keyword.total_ads
    fill_in "Total links", with: @keyword.total_links
    fill_in "User", with: @keyword.user_id
    click_on "Update Keyword"

    assert_text "Keyword was successfully updated"
    click_on "Back"
  end

  test "should destroy Keyword" do
    visit keyword_url(@keyword)
    accept_confirm { click_on "Destroy this keyword", match: :first }

    assert_text "Keyword was successfully destroyed"
  end
end
