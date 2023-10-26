class Score < ApplicationRecord
  belongs_to :user
  belongs_to :race

  serialize :points_by_category, JSON

  def self.get_scores_for_last_race
    Score.where(race: Race.last)
  end

  def calcul_score!
    reinitialize_score!
    bets = Bet.get_bets_for_user_and_race(self.user, self.race)
    bets.each do |bet|
      self.points_by_category[bet.boat.category] += bet.score
    end
    self.save!
  end

  private
  def reinitialize_score!
    categories = Race.last.categories
    self.points_by_category = categories.map { |category| [category['name'], 0]}.to_h
    self.save!
  end
end
