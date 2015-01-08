class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :review_id,
            :user_id,
            :score,
            presence: true
end
