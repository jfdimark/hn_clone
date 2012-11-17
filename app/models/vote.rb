class Vote < ActiveRecord::Base
  attr_accessible :object_id, :user_id, :object_type
  belongs_to :object, :polymorphic => true
  belongs_to :user



#todo: fix votable to work for both links and comments?
  def votable?(submitter_id)
    (submitter_id != user_id) && (Vote.where("object_id = ? AND user_id = ?", object_id, user_id).count == 0)
  end
end


# def link_votable?(current_user_id)
#   (current_user_id != self.user_id) && (self.collected_votes.all? { |vote| vote.user_id != current_user_id })
# end