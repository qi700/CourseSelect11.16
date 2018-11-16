require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save course without name" do
  course = Course.new
  assert_not course.save,"Saved the course without name"
  end


end
