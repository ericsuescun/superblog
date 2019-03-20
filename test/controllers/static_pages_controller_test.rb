require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
      get root_url
      assert_response :success
    end
  
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    # assert_select "title", "Home | Ruby on Rails Tutorial Sample App"
    assert_select "title", "Ruby on Rails Tutorial Sample App"  #Here we remove the HOME word so the test just check the secondary title
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
  end

  test "should get about" do
      get static_pages_about_url
      assert_response :success
      assert_select "title", "About | Ruby on Rails Tutorial Sample App"
    end

end
