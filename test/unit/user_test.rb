# encoding: UTF-8

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    User.drop
  end

  teardown do
  end

  test "create authenticate update delete one user" do
    password_test = "password.1"
    user1_attr = {email: "t_user1@test.com", password: password_test, password_confirmation: password_test}
    assert user = User.create_one(user1_attr)[:objid], "create one user and save to db"
    assert_equal User.find_one({_id: user})["email"], user1_attr[:email]
    assert User.authenticate(user1_attr[:email], password_test), "the user created should pass authentication use it's password"
    assert_nil User.authenticate(user1_attr[:email], "wrong_password"), "the user shouldn't pass authentication with wrong password"
    #TODO: update,delete
  end

  test "create user when email not presence" do
    password_test = "password.1"
    user20_attr = {email: "", password: password_test, password_confirmation: password_test}
    assert !User.create_one(user20_attr)[:objid]
  end

  test "create user when email format not correct" do
    password_test = "password.1"
    user21_attr = {email: "t_user1", password: password_test, password_confirmation: password_test}
    assert !User.create_one(user21_attr)[:objid]
  end

  test "create user when email already existed" do
    password_test = "password.1"
    user1_attr = {email: "t_user1@test.com", password: password_test, password_confirmation: password_test}
    assert User.create_one(user1_attr)[:objid]
    assert !User.create_one(user1_attr)[:objid]
  end

  test "create user when password not presence" do
    password_test = "password.1"
    user3_attr = {email: "t_user1@test.com", password: "", password_confirmation: password_test}
    assert !User.create_one(user3_attr)[:objid]
  end

  test "create user when password not consistent" do
    password_test = "password.1"
    user4_attr = {email: "t_user1@test.com", password: password_test, password_confirmation: "password.2"}
    assert !User.create_one(user4_attr)[:objid]
  end

  test "update: success and failure" do
    assert false, "essential fields should be filled when update"
  end

end

