require 'test_helper'

class EffortsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:efforts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create effort" do
    assert_difference('Effort.count') do
      post :create, :effort => { }
    end

    assert_redirected_to effort_path(assigns(:effort))
  end

  test "should show effort" do
    get :show, :id => efforts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => efforts(:one).to_param
    assert_response :success
  end

  test "should update effort" do
    put :update, :id => efforts(:one).to_param, :effort => { }
    assert_redirected_to effort_path(assigns(:effort))
  end

  test "should destroy effort" do
    assert_difference('Effort.count', -1) do
      delete :destroy, :id => efforts(:one).to_param
    end

    assert_redirected_to efforts_path
  end
end
