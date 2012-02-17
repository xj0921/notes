require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    User.drop
  end

  teardown do
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "login with correct email password and logout" do
    user1_attr = {email: "t_user1@test.com", nick_name: "test_user_1", password: "password.1", password_confirmation: "password.1"}
    assert User.create_one(user1_attr)[:objid]

    post :create, user: {email: "t_user1@test.com", submitted_password: "password.1"}
    assert_not_nil session[:user_id]
    assert_redirected_to home_user_path(session[:user_id])
    assert_equal "Logged in!", flash[:notice]

    get :destroy
    assert_nil session[:user_id]
    assert_redirected_to root_url
    assert_equal "logged out!", flash[:notice]
  end

  test "can not login with invalid email password" do
    user1_attr = {email: "t_user1@test.com", nick_name: "test_user_1", password: "password.1", password_confirmation: "password.1"}
    assert User.create_one(user1_attr)[:objid]

    post :create, user: {email: "t_user1@test.com", submitted_password: "password.2"}
    assert_nil session[:user_id]
    assert_redirected_to new_session_path
    assert_equal "Invalid email or password!", flash[:error]
  end
end
