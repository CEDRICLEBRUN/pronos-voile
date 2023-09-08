class Race < ApplicationRecord
  serialize :categories, Array
  validates :name, :year, :starting_date, presence: true
end
