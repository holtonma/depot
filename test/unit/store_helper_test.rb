
require 'test_helper'

class StoreHelperTest < ActiveSupport::TestCase
  include StoreHelper
  
  def test_aaron_job_quittal
    assert_equal 'Yes', did_you_quit_your_job?('Aaron')
  end
  
end
