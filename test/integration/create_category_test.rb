require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password", admin: true)
    sign_in_as(@admin_user)
  end

  # Check new category is created and views/categories/show.html.erb for the category name 
  test "get the new category and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "Sports" }}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  # Check new category is created and views/categories/show.html.erb does not show invalid category name 
  test "get the new category and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: " " }}
    end
    assert_match "saved", response.body
    assert_select "div.alert"
    assert_select "h3.alert-heading"
    assert_select "button.btn-close"
  end

end
