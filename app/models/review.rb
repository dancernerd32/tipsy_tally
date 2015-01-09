class Review < ActiveRecord::Base
  attr_accessor(:upvote, :downvote)

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

  def upvote(user_id, review_id)
    vote = Vote.find_or_create_by(
    user_id: user_id,
    review_id: review_id
    )
    # If the user has already votes, removes vote (sets it to 0)
    if vote.score == 1
      vote.score = 0
    else
      vote.score = 1
    end
    vote.save
  end

  def downvote(user_id, review_id)
    vote = Vote.find_or_create_by(
    user_id: user_id,
    review_id: review_id
    )
    # If the user has already votes, removes vote (sets it to 0)
    if vote.score == -1
      vote.score = 0
    else
      vote.score = -1
    end
    vote.save
  end
end
