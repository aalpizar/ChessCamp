class ReportsController < ApplicationController

	def index
		@active_camps = Camp.active.all.to_a
	end

end
