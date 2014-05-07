class RegistrationsController < ApplicationController
	before_action :set_registration, only: [:show, :edit, :update]

	def index		
	end

	def show
	end

	def new
		@registration = Registration.new
		# @camps = Camp.active.alphabetical.to_a
		# @students = Student.active.alphabetical.to_a
	end

	def edit
		# authorize! :update, @location
	end

	def create
		authorize! :new, @registration
		@registration = Registration.new(registration_params)
		if @registration.save
			redirect_to @registration, notice: "#{@registration.student.name} was registered for #{@registration.camp.name} Camp."
		else
			redirect_to home_path, warning: "#{@registration.student.name} was not registered for #{@registration.camp.name} Camp."
			# render action: 'new'
		end
	end

	def update
		authorize! :update, @registration
		if @registration.update(registration_params)
			redirect_to @registration, notice: "The registration was revised in the system."
		else
			render action: 'edit'
		end
	end

	def destroy
		authorize! :destroy, @registration
		@registration.destroy
		redirect_to registrations_url, notice: "The registration was removed from the system."
	end

	private
	def set_registration
		@registration = Registration.find(params[:id])
	end

	def registration_params
		params.require(:registration).permit(:camp_id, :student_id, :payment_status, :points_earned)
	end
end
