require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    User.coll.drop
    User.coll.insert({"record"=>1})
  end

  test "find one record" do
    assert ! User.coll.find_one().nil?, "nil when find one exist record"
  end
end

