require 'test_helper'

class ZusersControllerTest < ActionController::TestCase
  setup do
    @zuser = zusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:zusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create zuser" do
    assert_difference('Zuser.count') do
      post :create, zuser: {  }
    end

    assert_redirected_to zuser_path(assigns(:zuser))
  end

  test "should show zuser" do
    get :show, id: @zuser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @zuser
    assert_response :success
  end

  test "should update zuser" do
    patch :update, id: @zuser, zuser: {  }
    assert_redirected_to zuser_path(assigns(:zuser))
  end

  test "should destroy zuser" do
    assert_difference('Zuser.count', -1) do
      delete :destroy, id: @zuser
    end

    assert_redirected_to zusers_path
  end
end
