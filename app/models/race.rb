class Race < ApplicationRecord
  has_many :boats, dependent: :destroy

  serialize :categories, JSON
  validates :name, :year, :starting_date, presence: true
end
