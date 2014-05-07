class LocationsController < ApplicationController
	before_action :set_location, only: [:show, :edit, :update, :destroy]

	def index
		@active_locations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(10)
		@inactive_locations = Location.inactive.alphabetical.to_a
	end

	def show
		@camps = @location.camps.alphabetical.to_a
	end

	def new
		authorize! :new, @location
		@location = Location.new
	end

	def edit
		authorize! :update, @location
	end

	def create
		authorize! :new, @location
		@location = Location.new(location_params)
		if @location.save
			redirect_to @location, notice: "The #{@location.name} location was added to the system."
		else
			render action: 'new'
		end
	end

	def update
		authorize! :update, @location
		if @location.update(location_params)
			redirect_to @location, notice: "The #{@location.name} location was revised in the system."
		else
			render action: 'edit'
		end
	end

	def destroy
		authorize! :destroy, @location
		@location.destroy
    	if @location.destroy
      		flash[:notice] = "The location was removed from the system."
    	else
      		flash[:warning] = "Unable to remove location from the system."
    	end
    	redirect_to locations_url
	end

	private
	def set_location
		@location = Location.find(params[:id])
	end

	def location_params
		params.require(:location).permit(:name, :street_1, :street_2, :city, :state, :zip, :max_capacity, :latitude, :longitude, :active)
	end

end
