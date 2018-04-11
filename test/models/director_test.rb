require File.dirname(__FILE__) + '/../test_helper'

class DirectorTest < ActiveSupport::TestCase
  test "test_name" do
    director = Director.create(:first_name => 'Joseph', :last_name => 'Smith')
    assert_equal 'Joseph Smith', director.name
  end
end
