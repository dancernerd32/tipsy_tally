class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.boolean :alcoholic, null: false
      t.text :description, null: false
      t.timestamps
    end
  end
end
