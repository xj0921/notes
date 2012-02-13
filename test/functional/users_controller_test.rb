require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    User.drop
  end

  teardown do
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get show for user info" do
    get :show
    assert_response :success
  end

  test "create new user" do
    assert_difference('User.find.count') do
      post :create, user: {email: "abc@test.com", password: "password.1", password_confirmation: "password.1"}
    end
    assert_redirected_to new_session_path
    assert_equal "user successfully created,please login.", flash[:notice]
  end

  test "create new user failed for invalid data" do
    assert_no_difference('User.find.count') do
      post :create, user: {email: "", password: "password.1", password_confirmation: "password.1"}
    end
    assert_redirected_to new_user_path
    #assert_template "new"
    assert_not_nil flash[:error]
  end

  test "update user info" do
    assert false, "this feature to be done."
    assert_difference('User.find.count') do
      post :create, user: {email: "abc@test.com", password: "password.1", password_confirmation: "password.1"}
    end
    user = User.find_one({email: "abc@test.com"})
    old_name = user[:nick_name]
    put :update, user: {ObjectId: user["_id"], nick_name: "test_name_1", current_password: "password.1"}
    new_name = (User.find({_id: user['_id']}).first)[:nick_name]
    assert_not_equal old_name, new_name

    #assert_redirected_to
    assert_equal 'user information updated!', flash[:notice]
  end

end

