class SessionsController < ApplicationController
  def new
  end

  def create # creates a new session
  	@user = User.find_by(email: params[:session][:email].downcase)
  	if @user && @user.authenticate(params[:session][:password])
  		log_in(@user)
      if params[:session][:remember_me] == '1'
        remember(@user)
      else
        forget(@user)
      end
  		redirect_to(user_url(@user.id))
  	else
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
    if logged_in?
      log_out
    end
    redirect_to root_url
  end
end
