class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.string :title
      t.text :body
    end
  end
end
