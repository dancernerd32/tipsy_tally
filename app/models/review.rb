class Review < ActiveRecord::Base
  belongs_to :drink
  belongs_to :user
  has_many :votes,
           dependent: :destroy

  validates :rating,
            presence: true,
            inclusion: { within: 1..5 }

  validates :user_id,
            presence: true

  validates :drink_id,
            presence: true
end
