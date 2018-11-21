require 'test_helper'

class InformsControllerTest < ActionController::TestCase
   test "the truth" do
     assert true
   end
   test "should get index" do
    get :index
  end

  test "shoule get show"  do
    get :show,{'id'=>'2'}
  end

  test "should get update" do
    get :update,{'id'=>'1'}
  end

  test "should get edit" do
    get :edit,{'id'=>'1'}
  end

end
