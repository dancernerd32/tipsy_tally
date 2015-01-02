class AddUniqueConstraintToDrinkName < ActiveRecord::Migration
  def change
    add_index(:drinks, :name, unique: true)
  end
end
