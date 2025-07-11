require "test_helper"

class KeywordsUploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @keywords_upload = keywords_uploads(:one)
  end

  test "should get index" do
    get keywords_uploads_url
    assert_response :success
  end

  test "should get new" do
    get new_keywords_upload_url
    assert_response :success
  end

  test "should create keywords_upload" do
    assert_difference("KeywordsUpload.count") do
      post keywords_uploads_url, params: { keywords_upload: { status: @keywords_upload.status, user_id: @keywords_upload.user_id } }
    end

    assert_redirected_to keywords_upload_url(KeywordsUpload.last)
  end

  test "should show keywords_upload" do
    get keywords_upload_url(@keywords_upload)
    assert_response :success
  end

  test "should get edit" do
    get edit_keywords_upload_url(@keywords_upload)
    assert_response :success
  end

  test "should update keywords_upload" do
    patch keywords_upload_url(@keywords_upload), params: { keywords_upload: { status: @keywords_upload.status, user_id: @keywords_upload.user_id } }
    assert_redirected_to keywords_upload_url(@keywords_upload)
  end

  test "should destroy keywords_upload" do
    assert_difference("KeywordsUpload.count", -1) do
      delete keywords_upload_url(@keywords_upload)
    end

    assert_redirected_to keywords_uploads_url
  end
end
