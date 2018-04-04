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
    first_page_of_users = User.where(activated: true).paginate(page: 1)
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

  test 'do not display inactive accounts for index' do
    log_in_as(@notadmin)
    get users_path
    assert_select 'a[href=?]', user_path(@inactiveuser.id), text: @inactiveuser.name, count: 0
  end
end
