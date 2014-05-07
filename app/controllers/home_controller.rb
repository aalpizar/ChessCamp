class HomeController < ApplicationController
  def index
  	@upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(5)
  	@active_camps = Camp.active.size
  	@inactive_camps = Camp.inactive.size
  	@all_camps = Camp.all.size
  	
  	@inactive_instructors = Instructor.inactive.size
  	@active_instructors = Instructor.active.alphabetical.paginate(:page => params[:page]).per_page(3)
  	@all_instructors = Instructor.all.size
  	
  	@active_locations = Location.active.size
  	@inactive_locations = Location.inactive.size
  	@all_locations = Location.all.size
  	
  	@active_curriculums = Curriculum.active.size
  	@inactive_curriculums = Curriculum.inactive.size
  	@all_curriculums = Curriculum.all.size
  	
  	@active_students = Student.active.size
  	@inactive_students = Student.inactive.size
  	@all_students = Student.all.active.size
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
