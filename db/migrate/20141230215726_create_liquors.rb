class CreateLiquors < ActiveRecord::Migration
  def change
    create_table :liquors do |t|
      t.string :name, null: false
    end
  end
end
