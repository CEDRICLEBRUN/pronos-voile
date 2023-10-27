class RacesController < ApplicationController
  def show
    @race = Race.find(params[:id])
    @starting_time = Time.new(2023,10,29,13,05)
    @all_categories = @race.get_categories
    @categories = params[:category] ? [params[:category]] : @all_categories
    @crew = Crew.find(params[:crew_id])
    @my_leagues = Crew.includes_user(current_user)
    @users = User.accepted_in_league(@crew, @race, params[:category])
  end
end
