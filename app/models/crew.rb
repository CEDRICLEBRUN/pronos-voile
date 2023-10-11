class Crew < ApplicationRecord
  belongs_to :user
  has_many :admissions, dependent: :destroy

  validates :name, presence: { message: "Le nom de la ligue est obligatoire" }
  validates :name, uniqueness: { message: "Malheureusement ce nom est déjà pris" }
  validates :name, length: { in: 3..30 , message: "Le nom de la ligue doit être compris entre 3 et 30 caractères"}

  has_one_attached :logo
end
