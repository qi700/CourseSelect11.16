require 'test_helper'

class GradesControllerTest < ActionController::TestCase
   test "the truth" do
     assert true
   end
  test "should get index" do
    get :index
  end

  test "should get update" do
    get :update,{'id'=>'1'}
  end

end
