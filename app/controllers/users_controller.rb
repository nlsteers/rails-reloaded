class UsersController < ApplicationController
  
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to Tweetur, #{@user.name}!" #creates a welcome message on signup
  		redirect_to user_url(@user.id) #redirects to the newly created user resource, passing the id to get the show method
  	else
  		render 'new'
  	end
  end

  private

	  def user_params #method for passing only the params needed to create a new user
	  	params.require(:user).permit(:name, :email, :password, :password_confirmation) 
	  end

end
