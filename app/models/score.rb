class Score < ApplicationRecord
  belongs_to :user
  belongs_to :race

  serialize :points_by_category, JSON
end
