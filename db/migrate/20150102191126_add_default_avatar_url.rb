class AddDefaultAvatarUrl < ActiveRecord::Migration
  def change
    change_column :users, :avatar, :string, default: "https://s3-us-west-2.amazonaws.com/tipsy-tally/default.jpg"
  end
end
