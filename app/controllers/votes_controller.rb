class VotesController < ApplicationController

  def create
    unless session[:user_id]
      redirect_to root_url, :alert => "You must be logged in to vote."
      return
    end
    logger.info('----------object------------')
    logger.info(params[:object_type])
    @vote = Vote.new(:user_id => session[:user_id], :object_id => params[:object_id], :object_type => params[:object_type] )
    if @vote.save
      user = find_user(params[:object_type])
      user.update_attributes(:karma => user.karma += 1)
      redirect_to :back, :notice => "Upvoted!"
    else
      redirect_to :back, :alert => "You are not allowed to vote."
    end

  end

  private

  def find_user(object_type)
    if object_type == "Link"
      user = User.find(Link.find(@vote.object_id).user_id)
      #user = User.find(@vote.link.user_id)
    else
      user = User.find(Comment.find(@vote.object_id).user_id)
    end
  end

end
