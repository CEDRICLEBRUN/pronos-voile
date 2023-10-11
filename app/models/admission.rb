class Admission < ApplicationRecord
  belongs_to :user
  belongs_to :crew

  validates :user_id, uniqueness: { scope: :crew_id,
    message: "Vous ne pouvez demander à rejoindre une ligue qu'une seule fois" }
end
