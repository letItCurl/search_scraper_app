require "test_helper"

class KeywordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @keyword = keywords(:one)
  end

  test "should get index" do
    get keywords_url
    assert_response :success
  end

  test "should get new" do
    get new_keyword_url
    assert_response :success
  end

  test "should create keyword" do
    assert_difference("Keyword.count") do
      post keywords_url, params: { keyword: { html_cache: @keyword.html_cache, name: @keyword.name, total_ads: @keyword.total_ads, total_links: @keyword.total_links, user_id: @keyword.user_id } }
    end

    assert_redirected_to keyword_url(Keyword.last)
  end

  test "should show keyword" do
    get keyword_url(@keyword)
    assert_response :success
  end

  test "should get edit" do
    get edit_keyword_url(@keyword)
    assert_response :success
  end

  test "should update keyword" do
    patch keyword_url(@keyword), params: { keyword: { html_cache: @keyword.html_cache, name: @keyword.name, total_ads: @keyword.total_ads, total_links: @keyword.total_links, user_id: @keyword.user_id } }
    assert_redirected_to keyword_url(@keyword)
  end

  test "should destroy keyword" do
    assert_difference("Keyword.count", -1) do
      delete keyword_url(@keyword)
    end

    assert_redirected_to keywords_url
  end
end
