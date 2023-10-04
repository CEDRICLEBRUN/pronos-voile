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
      Boat.where(race: Race.last, category: category).order(:category, :name)
    else
      Boat.where(race: Race.last).order(:category, :name)
    end
  end
end
