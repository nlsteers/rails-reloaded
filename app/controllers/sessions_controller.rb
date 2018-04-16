class SessionsController < ApplicationController
  def new
  end

  # creates a new session
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in(@user)
        if params[:session][:remember_me] == '1'
          remember(@user)
        else
          forget(@user)
        end
        redirect_back_or(user_url(@user.id))
      else
        flash[:warning] = 'Account not activated, check your email for the activation link'
        redirect_to login_url
      end
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
