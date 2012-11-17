class AddKarmaToUser < ActiveRecord::Migration
  def up
    add_column :users, :karma, :integer, :default => 0
  end

  def down
    remove_column :users, :karma
  end
end
