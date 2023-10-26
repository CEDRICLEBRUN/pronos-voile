class UpdateResultsJob < ApplicationJob
  queue_as :default

  def perform()
    puts 'Deleting results'
    delete_results
    puts 'Deleting results done'

    puts 'Creating results'
    create_results
    puts "Crating results done"

    puts 'Calcul score in progress'
    score_calculation
    puts 'Calcul score done'
  end

  private
  def delete_results
    Result.includes(:boat).where(boat: {race: Race.last}).destroy_all
  end

  def create_results
    file_paths = [
      'app/jobs/fixtures/ultim.csv',
      'app/jobs/fixtures/imoca.csv',
      'app/jobs/fixtures/ocean_fifty.csv',
      'app/jobs/fixtures/class_fourty.csv'
    ]
    file_paths.each do |file_path|
      CSV.foreach(file_path, headers: true, col_sep: ";") do |row|
        boat = Boat.where(name: row['boat_name'], race: Race.last).first
        result = Result.new(
          result_position: row[0]
        )
        result.boat = boat
        result.save!
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
