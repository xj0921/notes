require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    User.coll.drop
    @password_test = "password.1"
    @user1_attr = {email: "t_user1@test.com", nick_name: "test_user_1", password: @password_test, password_confirmation: @password_test}
    @user2_attr = {email: "", nick_name: "test_user_1", password: @password_test, password_confirmation: @password_test}
    @user3_attr = {email: "t_user1@test.com", nick_name: "test_user_1", password: "", password_confirmation: @password_test}
    @user4_attr = {email: "t_user1@test.com", nick_name: "test_user_1", password: @password_test, password_confirmation: "password.2"}
  end

  teardown do
  end

  test "create authenticate update delete one user" do
    assert User.create_one(@user1_attr), "create one user and save to db"
    assert User.authenticate(@user1_attr[:email], @password_test), "the user created should pass authentication use it's password"
    assert_nil User.authenticate(@user1_attr[:email], "wrong_password"), "the user shouldn't pass authentication with wrong password"
    #TODO: update,delete
  end

  test "create user when email not presence" do
    assert !User.create_one(@user2_attr)
  end

  test "create user when password not presence" do
    assert !User.create_one(@user3_attr)
  end

  test "create user when password not consistent" do
    assert !User.create_one(@user4_attr)
  end

  test "need essential fields when update" do
    assert false
  end

end

