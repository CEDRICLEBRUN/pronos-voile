class CrewsController < ApplicationController
  def index
    @crews = Crew.all
    @admission = Admission.new
  end

  def show
  end

  def new
    @crew = Crew.new
  end

  def create
    @crew = Crew.new(crew_params)
    @crew.user = current_user
    if @crew.save
      redirect_to crew_race_path(@crew, Race.last)
    else
      flash[:notice] = @crew.errors.first.message
      redirect_to new_crew_path
    end
  end

  private

  def crew_params
    params.require(:crew).permit(:name, :logo)
  end
end
