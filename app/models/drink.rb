class Drink < ActiveRecord::Base
  belongs_to :user
  has_many :drink_liquors
  has_many :reviews

  has_many :liquors,
           through: :drink_liquors

  # accepts_nested_attributes_for :drink_liquors
  accepts_nested_attributes_for :liquors

  validates :name,
            presence: true,
            length: { minimum: 3 },
            uniqueness: true
  validates :description, presence: true
  validates :liquors,
            presence: {
              if: :alcoholic,
              message: "can't be blank if alcoholic"
            }
end
