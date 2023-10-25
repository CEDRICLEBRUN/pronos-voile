class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bets, dependent: :destroy
  has_many :crews, dependent: :destroy
  has_many :admissions, dependent: :destroy

  validates :first_name, :last_name, :username, presence: true
  validates :email, uniqueness: true

  has_one_attached :avatar
  before_create :assign_avatar

  def self.accepted_in_league(crew)
    owner = User.includes(:crews).where(crews: { id: crew.id })
    accepted_users = User.includes(:admissions).where(admissions: { crew: crew, status: "accepted" })
    owner + accepted_users
  end

  private
  def assign_avatar
    return if avatar.attached?

    photoavatar = URI.open('https://res.cloudinary.com/dv67de4qe/image/upload/v1654783466/avatar_cwi0wm.jpg')
    avatar.attach(io: photoavatar, filename: 'avatar.png', content_type: 'image/png')
  end
end
