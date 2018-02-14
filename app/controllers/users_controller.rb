class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_url(@user.id)
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:info] = "User deleted"
    redirect_to users_url
  end

  private

	  def user_params #method for passing only the params needed to create a new user
	  	params.require(:user).permit(:name, :email, :password, :password_confirmation) 
	  end

    # confirms a logged-in user

    def logged_in_user
      unless logged_in?
        store_location
        flash[:warning] = "Please log in"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
