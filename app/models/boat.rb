class Boat < ApplicationRecord
  belongs_to :race

  validates :name, :first_skipper_name, :first_skipper_nationality, :category, presence: true
end
