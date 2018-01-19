module SessionsHelper

	# Logs in a user
	def log_in(user)
		session[:user_id] = user.id
	end

	# Logs out a user
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	# returns the logged in user
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def logged_in?
		!current_user.nil?
	end
end
