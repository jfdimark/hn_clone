class Link < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :comment_count

  validates :title, :url, :presence => true
  validates :url, :uniqueness => true
  has_many :comments
  has_many :votes
  belongs_to :user

end
