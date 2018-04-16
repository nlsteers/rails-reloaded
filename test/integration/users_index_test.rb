require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:testuser)
    @notadmin = users(:otheruser)
    @inactiveuser = users(:inactiveuser)
  end

  test 'test user index pagination and delete links as admin' do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user.id), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user.id), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@notadmin)
    end
  end

  test 'index as notadmin' do
    log_in_as(@notadmin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test 'do not display inactive accounts for index to nonadmins' do
    log_in_as(@notadmin)
    get users_path
    assert_select 'a[href=?]', user_path(@inactiveuser.id), text: @inactiveuser.name, count: 0
  end

  test 'do display inactive accounts for index to admins' do
    log_in_as(@admin)
    get users_path
    assert_select 'a[href=?]', user_path(@inactiveuser.id), text: @inactiveuser.name, count: 1
  end

  test 'do not show inactive account profiles if not admin' do
    log_in_as(@notadmin)
    get user_path(@inactiveuser.id)
    assert_redirected_to root_url
  end

  test 'show inactive account profiles to admins' do
    log_in_as(@admin)
    get user_path(@inactiveuser.id)
    assert_select 'h1', text: @inactiveuser.name, count: 1
  end
end
