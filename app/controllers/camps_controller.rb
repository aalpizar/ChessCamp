class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy]

  def index
    @camps = Camp.active.paginate(page: params[:page]).per_page(10)
    @upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
    @past_camps = Camp.past.chronological.paginate(:page => params[:page]).per_page(10)
    @inactive_camps = Camp.inactive.alphabetical.to_a
  end

  def show
    @instructors = @camp.instructors.alphabetical.to_a
  end

  def new
    authorize! :new, @camp
    @camp = Camp.new
  end

  def edit
    authorize! :update, @camp
    @active_instructors = Instructor.active.alphabetical
  end

  def create
    @camp = Camp.new(camp_params)
    if @camp.save
      flash[:notice] = "#{@camp.name} was revised in the system"
      redirect_to @camp
    else
      render action: 'new'
    end
  end

  def update
    authorize! :update, @camp
    if @camp.update(camp_params)
      redirect_to @camp, notice: "The camp #{@camp.name} (on #{@camp.start_date.strftime('%m/%d/%y')}) was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize! :destroy, @camp
    @camp = Camp.find(params[:id])
    @camp.destroy
    flash[:notice] = "Successfully destroyed #{@camp.name} from the system."
    redirect_to camps_url
  end

  private
    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(:curriculum_id, :cost, :start_date, :end_date, :time_slot, :max_students, :active, :instructor_ids => [])
    end
end
