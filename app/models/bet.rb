class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :boat

  validates :boat, :position, presence: true
  validates :user_id, uniqueness: {
    scope: :boat_id,
    message: "Vous ne pouvez choisir un bateau qu'une seule fois"
  }

  def self.get_bets_by_category(category, user)
    Bet.includes(:boat)
       .where(user: user, boat: { category: category, race: Race.last })
       .sort_by(&:position)
  end

  def self.get_bets_for_user_and_race(user, race)
    Bet.includes(:boat)
       .where(user: user, boat: { race: race })
  end

  def self.get_bets_for_last_race
    Bet.includes(:boat)
       .where(boat: { race: Race.last })
  end

  def update_score!
    boat = Boat.find(self.boat.id)
    if boat.result.position.nil?
      case Boat.where(category: boat.category).count
      when 1..10
        self.score = Boat.where(category: boat.category).count + 1
      when 11..20
        self.score = 12
      when 21..30
        self.score = 13
      when 31..40
        self.score = 14
      when 41..50
        self.score = 15
      when 51..60
        self.score = 16
      end
    elsif boat.result.position == self.position
      self.score = self.position - 3
    elsif boat.result.position in 1..3
      self.score = boat.result.position - 1
    elsif boat.result.position in 4..10
      self.score = boat.result.position
    elsif boat.result.position in 11..20
      self.score = 11
    elsif boat.result.position in 21..30
      self.score = 12
    elsif boat.result.position in 31..40
      self.score = 13
    elsif boat.result.position in 41..50
      self.score = 14
    end
    self.save!
  end
end
