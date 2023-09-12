class BoatController < ApplicationController
  def index
    @boats = Boat.all.sort_by(&:name)
  end

  def show
  end
end
