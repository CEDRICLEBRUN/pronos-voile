class TotalScore < ApplicationRecord
  belongs_to :user
  belongs_to :race

  def self.get_total_scores_for_last_race
    TotalScore.where(race: Race.last)
  end

  def update_total_score!
    reinitialize_total_score
    score = self.user.scores.where(race: self.race).first
    score.points_by_category.each do |point|
      self.points += point.last
    end
    self.save!
  end

  private
  def reinitialize_total_score!
    self.points = 0
    self.save!
  end
end
