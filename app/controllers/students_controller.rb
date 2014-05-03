class StudentsController < ApplicationController
	before_action :set_student, only: [:show, :edit, :update, :destroy]

	def index
		@active_students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(10)
		@inactive_students = Student.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
	end

	def show
		# authorize! :show, @student
		@camps = @student.camps.alphabetical.to_a
		@registrations = @student.registrations.to_a
	end

	def new
		authorize! :new, @student
		@student = Student.new
	end

	def edit
		authorize! :update, @student
	end

	def create
		authorize! :new, @student
		@student = Student.new(student_params)
		if @student.save
			redirect_to @student, notice: "The student #{@student.proper_name} was added to the system."
		else
			render action: 'new'
		end
	end

	def update
		authorize! :update, @student
		if @student.update(student_params)
			redirect_to @student, notice: "The student #{@student.proper_name} was revised in the system."
		else
			render action: 'edit'
		end
	end

	def destroy
		authorize! :destroy, @student
		@student.destroy
		redirect_to students_url, notice: "The student #{@student.proper_name} was removed from the system."
	end

	private
	def set_student
		@student = Student.find(params[:id])
	end

	def student_params
		params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active)
	end
end
