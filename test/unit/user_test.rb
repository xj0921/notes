require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    User.coll.drop
    @password_test = "password.1"
    @user1_attr = {email: "t_user1@test.com", name: "test_user_1", password: @password_test, password_confirmation: @password_test}
  end

  def teardown
  end

  test "create authenticate update delete one user" do
    assert User.create_one(@user1_attr), "create one user and save to db"
    assert User.authenticate(@user1_attr[:email], @password_test), "the user created should pass authentication use it's password"
    assert_nil User.authenticate(@user1_attr[:email], "wrong_password"), "the user shouldn't pass authentication with wrong password"
    #TODO: update,delete
  end

  test "need essential fields when create" do
  end

  test "need essential fields when update" do
  end

end

