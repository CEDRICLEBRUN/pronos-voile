class RacesController < ApplicationController
  def show
    @race = Race.find(params[:id])
    @all_categories = Race.last.categories
    @crew = Crew.find(params[:crew_id])
    @my_leagues = Crew.includes_user(current_user)
    @users = User.accepted_in_league(@crew)
    # @admission = @league. .where(user: current_user).first
  end
end
