require "test_helper"

class EndUser::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get end_user_relationships_index_url
    assert_response :success
  end
end
