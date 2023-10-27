class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @starting_date = Race.last.starting_date
    @starting_time = Time.new(2023,10,29,13,05)
  end
end
