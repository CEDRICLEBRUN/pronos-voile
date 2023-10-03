class BetsController < ApplicationController
  def index
    @categories = Race.last.categories
    @ultims = my_boats('Ultim')
    @imocas = my_boats('IMOCA')
    @ocean_fifties = my_boats('Ocean Fifty')
    @class_40s = my_boats('Class 40')
    # @rhum_monos = my_boats('Rhum Mono')
    # @rhum_multis = my_boats('Rhum Multi')
  end

  def new
  end

  def create
  end

  private
  def my_boats(category)
    Bet.includes(:boat).where(user: current_user, boat: { category: category, race: Race.last }).sort_by(&:position)
  end
end
