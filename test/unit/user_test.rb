require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    User.drop
  end

  teardown do
  end

  test "create authenticate update delete one user" do
    password_test = "password.1"
    user1_attr = {email: "t_user1@test.com", nick_name: "test_user_1", password: password_test, password_confirmation: password_test}
    assert User.create_one(user1_attr)[:status], "create one user and save to db"
    assert User.authenticate(user1_attr[:email], password_test), "the user created should pass authentication use it's password"
    assert_nil User.authenticate(user1_attr[:email], "wrong_password"), "the user shouldn't pass authentication with wrong password"
    #TODO: update,delete
  end

  test "create user when email not presence" do
    password_test = "password.1"
    user20_attr = {email: "", nick_name: "test_user_1", password: password_test, password_confirmation: password_test}
    assert !User.create_one(user20_attr)[:status]
  end

  test "create user when email format not correct" do
    password_test = "password.1"
    user21_attr = {email: "t_user1", nick_name: "test_user_1", password: password_test, password_confirmation: password_test}
    assert !User.create_one(user21_attr)[:status]
  end

  test "create user when email already existed" do
    password_test = "password.1"
    user1_attr = {email: "t_user1@test.com", nick_name: "test_user_1", password: password_test, password_confirmation: password_test}
    assert User.create_one(user1_attr)[:status]
    assert !User.create_one(user1_attr)[:status]
  end

  test "create user when password not presence" do
    password_test = "password.1"
    user3_attr = {email: "t_user1@test.com", nick_name: "test_user_1", password: "", password_confirmation: password_test}
    assert !User.create_one(user3_attr)[:status]
  end

  test "create user when password not consistent" do
    password_test = "password.1"
    user4_attr = {email: "t_user1@test.com", nick_name: "test_user_1", password: password_test, password_confirmation: "password.2"}
    assert !User.create_one(user4_attr)[:status]
  end

  test "fetch user info is same to the one created" do
    #TODO, 检查数据正确性
    assert false, "use info before/after created should be same"
  end

  test "need essential fields when update" do
    assert false, "essential fields should be filled when update"
  end

end

