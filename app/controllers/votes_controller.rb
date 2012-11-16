class VotesController < ApplicationController
  def create
    unless session[:user_id]
      redirect_to root_url, :alert => "You are not allowed to vote."
    end

    @vote = Vote.new(:user_id => session[:user_id], :link_id => params[:link_id])
    @link = Link.find_by_id(params[:link_id])
    if @vote.votable?(@link.user_id) and @vote.save
      redirect_to root_url, :notice => "Upvoted!"
    else
      redirect_to root_url, :alert => "You are not allowed to vote."
    end
  end
end
