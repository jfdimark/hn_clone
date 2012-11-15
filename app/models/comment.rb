class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :user_id
  belongs_to :link
  belongs_to :user
  validates :body, :presence => true
end
