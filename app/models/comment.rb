class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :user_id, :parent_id
  belongs_to :link
  belongs_to :user
  validates :body, :presence => true

  def editable?
    Time.now - created_at <= 900
  end

  def self.parse_comments!(link_id)
    collection = []
    comments = self.find_all_by_link_id(link_id)
    comments.each_with_index do |comment, index|
      if comment.parent_id == nil
        collection << comment
        # push array of children if there are any
        children_comments = self.find_all_by_parent_id(comment.id)
        collection << children_comments if children_comments.count > 0
      end
    end
    collection
  end
end
