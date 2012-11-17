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
    comments = ordered_comments(link_id, order_by)
    comments.each do |comment|
      if comment.parent_id == nil
        collection << comment
        children_comments = Comment.find_all_by_parent_id(comment.id)
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

  private

  def self.ordered_comments(link_id, order_by)
    if (order_by)
      comments = Comment.order("#{order_by} DESC")
    else
      comments = Comment.order('created_at DESC')
    end
    comments.find_all_by_link_id(link_id)
  end



end
