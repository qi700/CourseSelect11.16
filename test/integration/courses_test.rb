require 'test_helper'

class CoursesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can see the welcome page" do
    get courses_path

    end



end
