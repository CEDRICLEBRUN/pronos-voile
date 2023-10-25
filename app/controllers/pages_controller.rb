class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @starting_date = Race.last.starting_date
  end
end
