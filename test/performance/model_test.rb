require 'test_helper'
require 'rails/performance_test_help'

class ModelTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { :runs => 5, :metrics => [:wall_time, :memory]
  #                          :output => 'tmp/performance', :formats => [:flat] }

  def test_find_one_user
    100.times { User.find_one() }
  end
end
