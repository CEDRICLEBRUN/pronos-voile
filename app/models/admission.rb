class Admission < ApplicationRecord
  belongs_to :user
  belongs_to :crew
end
