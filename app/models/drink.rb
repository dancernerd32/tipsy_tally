class Drink < ActiveRecord::Base
  belongs_to :user
  has_many :drink_liquors,
           dependent: :destroy
  has_many :reviews,
           dependent: :destroy

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

  def self.search(search)
    if !search.nil? && !search.blank?
      Drink.where("name = ?", search)
    else
      Drink.all
    end
  end
end
