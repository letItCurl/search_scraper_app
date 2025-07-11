require "application_system_test_case"

class KeywordsUploadsTest < ApplicationSystemTestCase
  setup do
    @keywords_upload = keywords_uploads(:one)
  end

  test "visiting the index" do
    visit keywords_uploads_url
    assert_selector "h1", text: "Keywords uploads"
  end

  test "should create keywords upload" do
    visit keywords_uploads_url
    click_on "New keywords upload"

    fill_in "Status", with: @keywords_upload.status
    fill_in "User", with: @keywords_upload.user_id
    click_on "Create Keywords upload"

    assert_text "Keywords upload was successfully created"
    click_on "Back"
  end

  test "should update Keywords upload" do
    visit keywords_upload_url(@keywords_upload)
    click_on "Edit this keywords upload", match: :first

    fill_in "Status", with: @keywords_upload.status
    fill_in "User", with: @keywords_upload.user_id
    click_on "Update Keywords upload"

    assert_text "Keywords upload was successfully updated"
    click_on "Back"
  end

  test "should destroy Keywords upload" do
    visit keywords_upload_url(@keywords_upload)
    accept_confirm { click_on "Destroy this keywords upload", match: :first }

    assert_text "Keywords upload was successfully destroyed"
  end
end
