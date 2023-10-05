class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :boat

  validates :boat, :position, presence: true
  validates :user_id, uniqueness: {
    scope: :boat_id,
    message: "Vous ne pouvez choisir un bateau qu'une seule fois"
  }
end
