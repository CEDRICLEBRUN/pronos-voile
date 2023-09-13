class BoatsController < ApplicationController
  def index
    @boats = Boat.where(race: Race.last).order(:name).group_by(&:category)
  end

  def show
  end
end
