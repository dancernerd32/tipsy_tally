class AddColumnsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :drink_id, :integer, null: false
    add_column :reviews, :user_id, :integer, null: false
  end
end
