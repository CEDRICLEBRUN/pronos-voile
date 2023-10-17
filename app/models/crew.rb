class Crew < ApplicationRecord
  belongs_to :user
  has_many :admissions, dependent: :destroy

  validates :name, presence: { message: "Le nom de la ligue est obligatoire" }
  validates :name, uniqueness: { message: "Malheureusement ce nom est déjà pris" }
  validates :name, length: { in: 3..30 , message: "Le nom de la ligue doit être compris entre 3 et 30 caractères"}

  has_one_attached :logo

  def number_of_members
    self.admissions.where(status: "accepted").count + 1
  end

  def includes_user?(user)
    self.user == user || !self.admissions.where(user: user).empty?
  end

  def validation_done_for?(user)
    !self.admissions.where(status: "accepted", user: user).empty?
  end

  def waiting_validation_for?(user)
    !self.admissions.where(status: "pending", user: user).empty? && self.user != user
  end
end
