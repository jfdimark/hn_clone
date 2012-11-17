class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :user_id, :parent_id, :vote_count
  belongs_to :link
  belongs_to :user
  has_many :comments, :as => :object
  validates :body, :presence => true

  def editable?
    Time.now - created_at <= 900
  end

  # def vote_counter
  #   Vote.find_all_by_object_id(id).count #TODO: also add type=Link
  # end

  def self.parse_comments!(link_id, order_by)
    collection = []
    comments = self.find_all_by_link_id(link_id)
    if (order_by)
      comments = Comment.order("#{order_by} DESC")
    else
      comments = Comment.order('created_on DESC')
    end
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

  def self.update_votes
    comments = Comment.all
    comments.each { |comment| comment.update_attributes(:vote_count => Vote.find_all_by_object_id(comment.id).count) }
  end

  def comment_votable?(current_user_id)
    (current_user_id != self.user_id) && (self.collected_votes.all? { |vote| vote.user_id != current_user_id })
  end

  def collected_votes
    Vote.find_all_by_object_id(id)
  end

end
