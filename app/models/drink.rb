class Drink < ActiveRecord::Base
  belongs_to :user
  has_many :drink_liquors

  has_many :liquors,
           through: :drink_liquors

  # accepts_nested_attributes_for :drink_liquors
  accepts_nested_attributes_for :liquors

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true
  validates :alcoholic,
            inclusion: {
                         in: [true, false],
                         message: " Drink? You must choose either Yes or No"
                       }
  validates :liquors,
            presence: {
                        if: :alcoholic,
                        message: "can't be blank if alcoholic"
                      }
end
