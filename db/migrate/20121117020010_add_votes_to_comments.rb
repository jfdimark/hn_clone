class AddVotesToComments < ActiveRecord::Migration
  def up
    add_column :comments, :vote_count, :integer, :default => 0
  end

  def down
    remove_column :comments, :vote_count
  end

end
