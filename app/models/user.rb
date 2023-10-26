class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bets, dependent: :destroy
  has_many :crews, dependent: :destroy
  has_many :admissions, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :total_scores, dependent: :destroy

  validates :first_name, :last_name, :username, presence: true
  validates :email, uniqueness: true

  has_one_attached :avatar
  before_create :assign_avatar
  after_create :score_initialization, :total_score_initialization

  def self.accepted_in_league(crew, race, category = nil)
    owner = User.joins(:total_scores, :scores).includes(:crews).where(crews: { id: crew.id })
    accepted_users = User.joins(:total_scores, :scores).includes(:admissions).where(admissions: { crew: crew, status: "accepted" })
    players = owner + accepted_users
    if category
      return players.sort_by { |player| player.scores.where(race: race).first.points_by_category[category] }
    else
      return players.sort_by { |player| player.total_scores.where(race: race).first.points }
    end
  end

  private
  def assign_avatar
    return if avatar.attached?

    photoavatar = URI.open('https://res.cloudinary.com/dciokrtia/image/upload/v1698344511/development/6rvjnlu98a6o65w5q6w1qqzzqzii.jpg')
    avatar.attach(io: photoavatar, filename: 'avatar.png', content_type: 'image/png')
  end

  def score_initialization
    score = Score.new(
      race: Race.last,
      user: self,
    )
    categories = Race.last.categories
    score.points_by_category = categories.map { |category| [category['name'], 0]}.to_h
    score.save!
  end

  def total_score_initialization
    TotalScore.create!(
      race: Race.last,
      user: self,
      points: 0
    )
  end
end
