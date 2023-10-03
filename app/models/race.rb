class Race < ApplicationRecord
  has_many :boats, dependent: :destroy

  serialize :categories, Array
  validates :name, :year, :starting_date, presence: true
end
