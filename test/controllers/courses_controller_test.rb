require 'test_helper'

class CoursesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
  end

  test "shoule get edit"  do
    get :edit,{'id'=>'1'}
  end

  test "should get update" do
    get :update,{'id'=>'1'}
  end
  test "should get open" do
    get :open,{'id'=>'1'}
  end


  test "should get quit"do
    get :quit,{'id'=>'1'}
  end

end
