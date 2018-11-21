require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "shoule get destroy"  do
    get :destroy,{'id'=>'1'}
  end

  test "should get update" do
    get :update,{'id'=>'1'}
  end

end
