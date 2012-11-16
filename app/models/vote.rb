class Vote < ActiveRecord::Base
  attr_accessible :link_id, :user_id
  belongs_to :link
  belongs_to :user

  def votable?(submitter_id)
    (submitter_id != user_id) && (Vote.where("link_id = ? AND user_id = ?", link_id, user_id).count == 0)
  end


end
