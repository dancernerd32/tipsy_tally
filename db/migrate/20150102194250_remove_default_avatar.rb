class RemoveDefaultAvatar < ActiveRecord::Migration
  def change
  	change_column :users, :avatar, :string
  end
end
