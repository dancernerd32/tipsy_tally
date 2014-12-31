class CreateDrinkLiquors < ActiveRecord::Migration
  def change
    create_table :drink_liquors do |t|
      t.integer :liquor_id, null: false
      t.integer :drink_id, null: false
    end
  end
end
