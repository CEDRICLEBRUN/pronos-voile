class UpdateResultsJob < ApplicationJob
  require 'csv'
  require 'uri'
  require "open-uri"
  require "nokogiri"
  require "i18n"
  queue_as :default

  def perform()
    puts 'Deleting results'
    delete_results
    puts 'Deleting results done'

    puts 'Creating results'
    create_results
    puts "Creating results done"

    puts 'Calcul score in progress'
    score_calculation
    puts 'Calcul score done'
  end

  private
  def delete_results
    Result.includes(:boat).where(boat: {race: Race.last}).destroy_all
  end

  def create_results
    url = "https://www.transatjacquesvabre.org/le-classement"

    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML.parse(html_file)

    html_doc.search(".table-row").each do |element|
      name = element.search(".data-names").css('strong').text.upcase
      boat_name = I18n.transliterate(name).upcase
      boat = Boat.where(name: boat_name).first
      unless boat.nil? || boat.category == "IMOCA"
        result = Result.new
        result.position = element.search(".data-pos").css("span").text.to_i
        result.boat = boat
        result.save!
        puts result
      end
    end
  end

  def score_calculation
    puts 'Update bets score in progress'
    update_bets_score
    puts 'Update bets score done'

    puts 'Update scores in progress'
    update_scores
    puts "Update scores done"

    puts 'Update total_scores in progress'
    update_total_scores
    puts 'Update total_scores'
  end

  def update_bets_score
    bets = Bet.get_bets_for_last_race
    bets.each do |bet|
      bet.update_score!
    end
  end

  def update_scores
    scores = Score.get_scores_for_last_race
    scores.each do |score|
      score.calcul_score!
    end
  end

  def update_total_scores
    total_scores = TotalScore.get_total_scores_for_last_race
    total_scores.each do |total_score|
      total_score.update_total_score!
    end
  end
end
