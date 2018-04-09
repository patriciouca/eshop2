require File.dirname(__FILE__) + '/../test_helper'

class DirectorTest < ActiveSupport::TestCase
  test "test_name" do
    director = Director.create(:first_name => 'Joel', :last_name => 'Spolsky')
    assert_equal 'Joel Spolsky', director.name
  end
end
