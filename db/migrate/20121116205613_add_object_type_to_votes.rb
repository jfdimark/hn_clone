class AddObjectTypeToVotes < ActiveRecord::Migration
   def up
     add_column :votes, :object_type, :string
     execute "UPDATE votes SET object_type=\"Link\""
     rename_column :votes, :link_id, :object_id
   end

   def down
     rename_column :votes, :object_id, :link_id
     remove_column :votes, :object_type
   end
end
