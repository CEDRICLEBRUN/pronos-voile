class Boat < ApplicationRecord
  belongs_to :race
  has_many :bets

  validates :name, :first_skipper_name, :first_skipper_nationality, :category, presence: true
end
