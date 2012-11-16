class AddPointsColumnToLinks < ActiveRecord::Migration
  def up
    add_column :links, :points, :integer, :default => 0
  end

  def down
    remove_column :links, :points
  end

end
