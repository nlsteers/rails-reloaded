require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:testuser)
	end

	test 'unsuccessful edit' do
		log_in_as(@user)
		get edit_user_path(@user.id)
		assert_template 'users/edit'
		patch user_path(@user), params: { user: {name: "", email: "not@valid", password: "foo", password_confirmation: "bar"} }
		assert_template 'users/edit'
		assert_select 'div.alert', 'The form contains 4 errors.'
	end

	test 'successful edit with correct forwarding' do
		get edit_user_path(@user.id)
		log_in_as(@user)
		assert_redirected_to edit_user_url(@user.id)
		name = "Foo Bar"
		email = "foo@bar.com"
		patch user_path(@user), params: { user: { name: name, email: email, password: "", password_confirmation: "" } }
		assert_not flash.empty?
		assert_redirected_to user_path(@user.id)
		@user.reload
		assert_equal name, @user.name
		assert_equal email, @user.email
	end

	test 'forwarding remap does not persist on subsequent login attempts' do
		get edit_user_path(@user.id)
		assert_redirected_to login_path
		assert_equal edit_user_path(@user.id), session[:forwarding_path]
		log_in_as(@user)
		assert_redirected_to edit_user_url(@user.id)
		assert_not session[:forwarding_path]
		delete logout_path
		log_in_as(@user)
		assert_redirected_to user_path(@user.id)
	end
end
