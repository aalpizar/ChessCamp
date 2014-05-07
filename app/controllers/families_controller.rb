class FamiliesController < ApplicationController
	before_action :set_family, only: [:show, :edit, :update, :destroy]

	def index
		authorize! :read, @family
		@active_families = Family.active.alphabetical.paginate(:page => params[:page]).per_page(10)
		@inactive_families = Family.inactive.alphabetical.to_a
	end

	def show
		@students = @family.students.alphabetical.to_a
	end

	def new
		authorize! :new, @family
		@family = Family.new
		@students = @family.students.build
	end

	def edit
		authorize! :update, @family
	end

	def create
		authorize! :new, @family
		# @family.students.build if @family.students.nil? 
		@family = Family.new(family_params)
		# @family.students.each.family_id = @family.id
		if @family.save
			redirect_to @family, notice: "The #{@family.family_name} family was added to the system."
		else
			render action: 'new'
		end
	end

	def update
		authorize! :update, @family
		if @family.update(family_params)
			redirect_to @family, notice: "The #{@family.family_name} family was revised in the system."
		else
			render action: 'edit'
		end
	end

	def destroy
		authorize! :destroy, @family
		@family.destroy
		redirect_to families_url, warning: "The #{@family.family_name} family was not removed from the system."
	end

	private
	def set_family
		@family = Family.find(params[:id])
	end

	def family_params
		params.require(:family).permit(:id, :family_name, :parent_first_name, :email, :phone, :active, students_attributes: [:id, :first_name, :last_name, :date_of_birth, :rating, :active])
	end
end
