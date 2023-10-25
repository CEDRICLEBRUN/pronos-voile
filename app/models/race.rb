class Race < ApplicationRecord
  has_many :boats, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :total_scores, dependent: :destroy

  serialize :categories, JSON
  validates :name, :year, :starting_date, presence: true

  def self.find_logo_path(category)
    Race.last.categories.find { |item| item["name"] == category.first }["logo_path"]
  end

  def self.all_categories
    Race.last.categories
  end
end
