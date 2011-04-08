require 'test_helper'

class ServersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:servers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create server" do
    assert_difference('Server.count') do
      post :create, :server => { }
    end

    assert_redirected_to server_path(assigns(:server))
  end

  test "should show server" do
    get :show, :id => servers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => servers(:one).to_param
    assert_response :success
  end

  test "should update server" do
    put :update, :id => servers(:one).to_param, :server => { }
    assert_redirected_to server_path(assigns(:server))
  end

  test "should destroy server" do
    assert_difference('Server.count', -1) do
      delete :destroy, :id => servers(:one).to_param
    end

    assert_redirected_to servers_path
  end
end
