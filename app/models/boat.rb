class Boat < ApplicationRecord
  belongs_to :race
  has_many :bets, dependent: :destroy
  has_one :result, dependent: :destroy

  validates :name, :first_skipper_name, :first_skipper_nationality, :category, presence: true

  def self.get_all_by_category(category)
    Boat.joins(:race).where(races: {id: Race.last}, category: category).sort_by(&:name).map {|boat| "#{boat.name}"}
  end
end
