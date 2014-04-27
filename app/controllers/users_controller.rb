class UsersController < ApplicationController

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
			redirect_to @user, notice: "The user #{@user.username} was added to the system."
		else
			render action: 'new'
		end
	end

	def update
		if @user.update(user_params)
			redirect_to @user, notice: "The user #{@user.username} was revised in the system."
		else
			render action: 'edit'
		end
	end

	def destroy
		@user.destroy
		redirect_to instructors_url, notice: "The user #{@user.username} was removed from the system."
	end

	private
	def set_student
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:username, :instructor_id, :role, :active)
	end
end
