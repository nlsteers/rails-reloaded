require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser)
    @otheruser = users(:otheruser)
  end

  test 'should get new' do
    get signup_path
    assert_response :success
    assert_select 'title', full_title('Sign up')
  end

  test 'redirect edit when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'redirect update when not logged in' do
    patch user_path(@user.id), params: { user: { name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'redirect edit when logged in as wrong user' do
    log_in_as(@otheruser)
    get edit_user_path(@user.id)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test 'redirect update when logged in as wrong user' do
    log_in_as(@otheruser)
    patch user_path(@user.id), params: { user: { name: @user.name, email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test 'redirect index when not logged in' do
    get users_path
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test 'admin status cannot be edited via web' do
    log_in_as(@otheruser)
    assert_not @otheruser.admin?
    patch user_path(@otheruser.id), params: { user: { password: 'password', password_confirmation: 'password', admin: true } }
    assert_not @otheruser.reload.admin?
  end

  test 'redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      delete user_path(@user.id)
    end
    assert_redirected_to login_url
  end

  test 'redirect destroy when not admin' do
    log_in_as(@otheruser)
    assert_no_difference 'User.count' do
      delete user_path(@user.id)
    end
    assert_redirected_to root_url
  end
end
