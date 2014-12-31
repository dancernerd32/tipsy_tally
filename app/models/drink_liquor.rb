class DrinkLiquor < ActiveRecord::Base
  belongs_to :drink
  belongs_to :liquor
end
