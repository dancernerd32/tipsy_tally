class Review < ActiveRecord::Base
  belongs_to :drink
  belongs_to :user

  validates :rating,
            presence: true,
            inclusion: { within: 1..5 }

  validates :user_id,
            presence: true

  validates :drink_id,
            presence: true
end
