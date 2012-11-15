class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :user_id
end
