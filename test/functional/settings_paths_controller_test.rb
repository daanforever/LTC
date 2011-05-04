require 'test_helper'

class SettingsPathsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:settings_paths)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create settings_path" do
    assert_difference('SettingsPath.count') do
      post :create, :settings_path => { }
    end

    assert_redirected_to settings_path_path(assigns(:settings_path))
  end

  test "should show settings_path" do
    get :show, :id => settings_paths(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => settings_paths(:one).to_param
    assert_response :success
  end

  test "should update settings_path" do
    put :update, :id => settings_paths(:one).to_param, :settings_path => { }
    assert_redirected_to settings_path_path(assigns(:settings_path))
  end

  test "should destroy settings_path" do
    assert_difference('SettingsPath.count', -1) do
      delete :destroy, :id => settings_paths(:one).to_param
    end

    assert_redirected_to settings_paths_path
  end
end
