class UsersController < ApplicationController

	before_action :check_login, except: [:new, :create]

	def index
	end

	def show
	end

	def new
		@user = User.new
	end

	def edit
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to(@user, :notice => 'User was successfully created.')
		else
			render :action => "new"
		end
	end

	def update
		@user = current_user
		if @user.update_attributes(user_params)
			redirect_to(@user, :notice => 'User was successfully updated.')
		else
			render :action => "edit"
		end
	end

	def destroy
		@user.destroy
		redirect_to instructors_url, notice: "The user #{@user.username} was removed from the system."
	end

	private

	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :instructor_id, :role, :active)
	end
end
