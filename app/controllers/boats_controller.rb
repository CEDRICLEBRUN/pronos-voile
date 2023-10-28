class BoatsController < ApplicationController
  def index
    @boats = filtered_boats(params[:category])
    @categories = Race.last.categories
  end

  def show
  end

  private
  def filtered_boats(category)
    if category
      Boat.where(race: Race.last, category: category).order(:name)
    else
      Boat.where(race: Race.last).order(:name)
    end
  end
end
