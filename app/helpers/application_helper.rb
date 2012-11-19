module ApplicationHelper

	def votable?(object)
    (@current_user.id != object.user_id) && (object.collected_votes.all? { |vote| vote.user_id != @current_user.id }) if @current_user
	end


end
