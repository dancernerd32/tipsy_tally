class Liquor < ActiveRecord::Base
  has_many :drink_liquors
  has_many :drinks, through: :drink_liquors
end
