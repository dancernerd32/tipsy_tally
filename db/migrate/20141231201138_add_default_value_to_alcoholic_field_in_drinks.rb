class AddDefaultValueToAlcoholicFieldInDrinks < ActiveRecord::Migration
  def change
    change_column_default(:drinks, :alcoholic, true)
  end
end
