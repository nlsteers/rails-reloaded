module SessionsHelper

	# logs in a user
	def log_in(user)
		session[:user_id] = user.id
	end

	# remembers a user in a persistent session
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# logs out a user
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	# returns the logged in user
	def current_user
		if (session[:user_id])
			user_id = session[:user_id]
			@current_user ||= User.find_by(id: user_id)
		elsif (cookies.signed[:user_id])
			user_id = cookies.signed[:user_id]
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	def current_user?(user)
		user == current_user
	end

	# returns true if the user is logged in
	def logged_in?
		!current_user.nil?
	end

	# redirect to stored location
	def redirect_back_or(default) 
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
		session.delete(:forwarding_path)
	end

	# stores the url trying to be accessed
	def store_location
		if request.get?
			session[:forwarding_url] = request.original_url
			session[:forwarding_path] = request.original_fullpath
		end
	end
end
