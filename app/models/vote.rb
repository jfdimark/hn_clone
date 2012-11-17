class Vote < ActiveRecord::Base
  attr_accessible :object_id, :user_id, :object_type
  belongs_to :object, :polymorphic => true
  belongs_to :user

  # def votable?(submitter_id)
  #   (submitter_id != user_id) && (Vote.where("object_id = ? AND user_id = ?", object_id, user_id).count == 0)
  # end

end

